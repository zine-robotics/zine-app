import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/message_response_model.dart';
import 'package:zineapp2023/models/newUser.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/backend_properties.dart';

import '../../../../models/events.dart';
import '../../../../models/message_update.dart';
import '../../../../models/rooms.dart';
import '../repo/chat_repo.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/database/database.dart';
import 'package:drift/drift.dart' as drift;
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class ChatRoomViewModel extends ChangeNotifier {
  final UserProv userProv;
  final AppDb db;

  ChatRoomViewModel({required this.userProv, required this.db}) {
    initializeWebSocket(); //constructor to initialize the webSocket for single time only!!
    _isNewRoomData = false;
  }

  //===================================================NEWER CODE====================================================//
  final chatP = ChatRepo();
  final Map<String, dynamic> _subscriptions = {};

  dynamic allData;
  dynamic replyTo;
  dynamic replyUsername;
  FocusNode replyfocus = FocusNode();

  String currRoomId = "645";
  final name = "Announcement";
  Map<String, dynamic> chatSubscription = {};
  final picker = ImagePicker();
  late MessageModel selectedReplyMessage;

  Map<String, Timestamp> lastChats = {};

  //-------------------------------------------------message fetching using http--------------------//
  List<MessageModel> messages = [];
  Map<String, RoomMemberModel> currentRoomMembers = {};
  final bool _isLoaded = false; //It should be true at
  final bool _isError = false;
  bool _isNewRoomData = false; //track new Room data
  bool loadingAPIMessages = false;
  Set<String> activeRoomSubscriptions = {};
  int? focusMessageId;
  Map<int, GlobalKey> messageKeys = {};

  bool get isLoaded => _isLoaded;
  bool get isError => _isError;
  bool get isNewRoomData => _isNewRoomData;
  final ScrollController scrollController = ScrollController();
  //-------------------------------------------------------------stomp_client-----------------------------------------//

  late StompClient _client;

  bool isConnected = false;

  // late final messageData;

  void initializeWebSocket() {
    String uid = userProv.getUserInfo.uid!;
    _client = StompClient(
      config: StompConfig(
        useSockJS: true,
        url: BackendProperties.websocketUri.toString(),
        onConnect: onConnectCallback,
        stompConnectHeaders: {"Authorization": uid},
        onWebSocketError: (dynamic error) =>
            logger.e('WebSocket error: $error'),
      ),
    );
    _client.activate();
    logger.i("WebSocket initialized with uid: $uid");
  }

  void onConnectCallback(StompFrame connectFrame) {
    logger.i("WebSocket connected: ${connectFrame.headers}");
    isConnected = true;
  }

  // void assignGlobalKeystoMessages() {
  //   for (var message in messages) {
  //     messageKeys[message.id!] = GlobalKey();
  //   }
  // }

  void subscribeToActiveMember(String currRoomID, AppDb db) {
     _client.subscribe(
        destination: "/room/$currRoomID/active-users",
        // headers: BackendProperties.getHeaders(),
        headers: {"roomId": currRoomID},
        callback: (StompFrame frame) async {
          try {
            // _activeMembers = [];
            final List<dynamic> activeMemberData = json.decode(frame.body!);
            final List<String> activeMemberList =
                activeMemberData.map((item) => item.toString()).toList();
            currentRoomMembers =
                await db.getRoomMembersByRoomId(int.parse(currRoomID));
            currentRoomMembers.forEach((key, value) {
              if (activeMemberList.contains(value.email)) {
                value.isActive = true;
              }
            });

            logger.d("Current Room Members: $currentRoomMembers");

            notifyListeners();
          } catch (e) {
            logger.e(e);
          }
        });
  }

  void subscribeToRoom(String roomId, AppDb db) {
    if (!_client.connected) {
      // logger.d("client is not connected");
      return;
    }
    activeRoomSubscriptions.add(roomId);
    final subscription = _client.subscribe(
      destination: '/room/$roomId', //  widget.chatId
      headers: {'roomId': roomId}, //BackendProperties.getHeaders(),
      callback: (StompFrame frame) async {
        try {
          //Map the frame body to messageModel
          final Map<String, dynamic> messageData = json.decode(frame.body!);
          logger.i("Received message: $messageData");
          MessageUpdateResponseModel messageRecieved =
              MessageUpdateResponseModel.fromJson(messageData);

          // print(
          //     "Timestamp Local ${messageRecieved.body!.timestamp!.toLocal()}");
          // print("Timestamp UTC ${messageRecieved.body!.timestamp!}");

          MessageModel? roomMessage;

          if (messageRecieved.update == 'poll-update' &&
              messageRecieved.pollUpdate != null) {
            logger.d("Received poll update");
            //Handle Poll Update
            int pollIndex = messages.indexWhere(
              (element) => element.id == messageRecieved.pollUpdate!.chatItemId,
            );
            messages[pollIndex].poll!.update(messageRecieved.pollUpdate!);
            roomMessage = messages[pollIndex];
            focusMessageId = roomMessage.id;
          } else if (messageRecieved.update == 'new-message' &&
              messageRecieved.body != null) {
            messageRecieved.body!.timestamp =
                messageRecieved.body!.timestamp!.toLocal();
            roomMessage = messageRecieved.toModel();
            messages.add(roomMessage);
            messageKeys[roomMessage.id!] = GlobalKey();
          }
          notifyListeners();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToFocusedMessage(roomMessage!.id);
          });
          await workerToSaveMessages([roomMessage!], db, roomId);
        } catch (e) {
          logger.e(e);
        } finally {
          //notifyListeners();
        }
      },
    );

    _subscriptions[roomId] = subscription;
    currRoomId = roomId;
  }

  void updateRooms() {
    userProjects = allrooms
            ?.where((room) => room.type != "workshop")
            .toList()
            .cast<Rooms>() ??
        [];
    userWorkshop = allrooms
            ?.where((room) => room.type == "workshop")
            .toList()
            .cast<Rooms>() ??
        [];
  }

  //---------------------------------------------MODIFY: ADD multiple subscribtion->----------------//
  void unsubscribeFromRoom(String roomId) {
    logger.i("attempting to unsubscribe roomId:$roomId");
    final subscription = _subscriptions[roomId];
    if (subscription != null) {
      try {
        // subscription.unsubscribe(unsubscribeHeaders: {});
        subscription();
        logger.i("Unsubscribed from room: $roomId");
      } catch (e) {
        logger.e("Error unsubscribing from room $roomId: $e");
      } finally {
        _subscriptions.remove(roomId);
      }
    } else {
      logger.w("No active subscription found for room: $roomId");
    }
  }

  void setRoomId(String roomId, AppDb db) {
    // print("insdie the setRoomID:$roomId");
    if (currRoomId != roomId) {
      unsubscribeFromRoom(currRoomId);
      currRoomId = roomId;
      subscribeToRoom(roomId, db);
      subscribeToActiveMember(roomId, db);
    }
  }

  void scrollToFocusedMessage(int? messageId) {
    if (messageId == null) return;
    final key = messageKeys[messageId];
    if (key != null) {
      final context = key.currentContext;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
        );
      }
    }
  }

  void sendMessage(String userMessage, String roomName) async {
    // int? roomId=roomNameToId[roomName];
    if (!_client.connected) {
      logger.e("Not connected to the WebSocket server.");
      return;
    }

    final messageData = {
      "type": "text",
      "sentFrom": userProv.getUserInfo.id!,
      "roomId": int.parse(currRoomId),
      "text": {"content": userMessage.trim()},
      "replyTo": replyTo,
    };

    replyTo = null;
    // print("during sent replyTo:$replyTo \t replyusername:$replyUsername");
    final jsonBody = json.encode(messageData);
    // logger.i("Sending message: $jsonBody");
    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      logger.i("Message sent: $jsonBody");
    } catch (e) {
      logger.e('Not connected to the WebSocket server.$e');
    }

    notifyListeners();
  }

  //-------------------------------------------------it will fetch all room data---------------------------------------------//

  List<Rooms>? userProjects;
  List<Rooms>? allrooms;
  List<Rooms>? userWorkshop;
  List<Rooms>? announcement;
  bool isRoomLoaded = false;

  // List<Rooms>? get userProjects => _userProjects;
  // List<Rooms>? get userWorkshop => _userWorkshop;
  // List<Rooms>? get announcement => _announcement;
  // bool get isRoomLoaded => _isRoomLoaded;

  var fMessaging = FirebaseMessaging.instance;

  void userReplyText(MessageModel message) {
    selectedReplyMessage = message;
    replyTo = message.id;
    replyUsername = message.sender!.name.toString();

    replyfocus.requestFocus();

    notifyListeners();
  }

  void userCancelReply() {
    replyTo = null;
    notifyListeners();
  }

  dynamic userGetMessageById(List<MessageModel> chats, String replyTo) {
    // print("inside the uerGetmessagebyId: chats replyTo:${replyTo}");

    Iterable<MessageModel> msg =
        chats.where((element) => element.id.toString() == replyTo);
    if (msg.isNotEmpty) {
      return msg.first;
    }
    return null;
  }

  //-----------------------------------------------------Update LastSeen to Room------------------------------------//
  dynamic updateSeen(String emailId, String roomId, DateTime userLastSeen,
      DateTime lastMessageTimestamp, int unreadMessages) async {
    Uri url = BackendProperties.updateLastSeenUri(emailId, roomId);
    String uid = userProv.getUserInfo.uid!;
    // print("inside teh updateSeen for email:$email_id and roomid:$room_id");
    try {
      final Map<String, dynamic> jsonData = {
        'info': {
          'userLastSeen': userLastSeen.millisecondsSinceEpoch,
          'lastMessageTimestamp': lastMessageTimestamp.millisecondsSinceEpoch,
          'unreadMessages': unreadMessages
        }
      };
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $uid',
          'Content-Type': 'application/json',
          ...BackendProperties.getHeaders()
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        logger.t("Seen for room: $roomId updated");
      } else {
        logger.e("Error occurred during PUT operation");
      }
    } catch (e) {
      logger.e("Error during PUT operation: $e");
    }
  }

  //-----------------------------------------------------INFO about lastMessageSeen------------------------------------//
  LastSeen? _lastSeen;
  LastSeen? get lastSeen => _lastSeen;

  dynamic getLastSeen(String emailId, String roomId) async {
    // print("inside the getlastseen for roomid:$roomId");
    _lastSeen = await chatP.fetchLastSeen(emailId, roomId);
    notifyListeners();
  }

//------------------------------------------------------INFO about Active member-----------------------------//
  final List<RoomMemberModel> _activeMembers = [];
  List<RoomMemberModel>? get activeMembers => _activeMembers;

  //------------------------------------------------------------chat text value-------------------------------------------//
  String _text = "";
  get text => _text;

  void setText(String value) {
    _text = value;
  }

//===============================================================LOCAL STORAGE========================================================//
  //------------------------------------------------------------save/fetch RoomMemberDetails------------------------------------------//
  Future<RoomMemberModel?> getRoomMember(AppDb db, String memberId) async {
    // Check if the member is already cached
    if (currentRoomMembers.containsKey(memberId.toString())) {
      // logger.d("Cached User Details");
      return currentRoomMembers[memberId.toString()];
    }

    final roomMemberDB = await db.fetchRoomMemberById(int.parse(memberId));
    if (roomMemberDB == null) {
      return null;
    }
    final roomMemberModel = roomMemberDB.toModel();
    currentRoomMembers[memberId.toString()] = roomMemberModel;
    logger.d("Added User Details");
    return roomMemberModel;
  }

  Future<void> fetchRoomMembersAndStoreInDB(AppDb db, String roomId) async {
    // logger.i("Fetching Room Members");
    try {
      List<RoomMemberModel>? allRoomMembers =
          await chatP.fetchTotalActiveMember(roomId);
      // logger.d("check totalactivemember:${allRoomMembers.length} ");
      if (allRoomMembers.isNotEmpty) {
        List<int> memberIds = [];
        await db.batch((batch) async {
          for (RoomMemberModel roomMember in allRoomMembers) {
            final roomMemberCompanion = RoomMemberTableCompanion(
              name: drift.Value(roomMember.name ?? "anonymous"),
              email: drift.Value(roomMember.email ?? "random@gmail.com"),
              role: drift.Value(roomMember.role ?? "user"),
              id: drift.Value(roomMember.id),
              dpUrl: drift.Value(
                await saveFileToLocalStorage(
                  roomMember.dpUrl.toString(),
                  roomMember.id.toString(),
                  "user_dp",
                ),
              ),
            );
            batch.insert(
              db.roomMemberTable,
              roomMemberCompanion,
              mode: InsertMode.replace,
            );
            memberIds.add(roomMember.id);
          }
        });
        await db.saveRoomMemberMapping(int.parse(roomId), memberIds);
      }
    } catch (e) {
      logger.e("ERROR in saveRoomMemberToLocalDb: $e");
    }
  }

  void updateUnreadMessagesToZero(String roomId) async {
    allrooms = allrooms?.map((room) {
      if (room.id.toString() == roomId) {
        room.unreadMessages = 0;
        logger.d("Setting unread meesage of $roomId to Zero");
      }
      return room;
    }).toList();

    announcement = announcement?.map((room) {
      if (room.id.toString() == roomId) {
        room.unreadMessages = 0;
      }
      return room;
    }).toList();

    updateRooms();
    notifyListeners();
    // saveRoomsToLocalDb(announcement, db);
    // saveRoomsToLocalDb(allrooms, db);

    // fetchAllRoomDataFromLocalDB(db);
  }

  Future<List<RoomMemberModel>?> fetchRoomMemberDetailsFromLocalDb(
      AppDb db, List<String>? allEmail) async {
    if (allEmail == null || allEmail.isEmpty) {
      return null;
    }
    final query = db.select(db.roomMemberTable)
      ..where((tbl) => tbl.email.isIn(allEmail));
    final roomMemberRows = await query.get();
    final roomMembers = roomMemberRows.map((row) {
      return RoomMemberModel(
        id: row.id,
        name: row.name,
        email: row.email,
        role: row.role,
        dpUrl: row.dpUrl,
      );
    }).toList();

    return roomMembers;
  }

  //-----------------------------------------------------------save RoomDetails to local DB-------------------------------------------//
  static List<RoomsTableCompanion>? _apiRoomData;

  Future<List<Rooms>?> saveRoomsToLocalDb(
      List<Rooms>? allRooms, AppDb db) async {
    try {
      for (Rooms room in allRooms!) {
        final roomCompanion = RoomsTableCompanion(
            id: room.id != null ? drift.Value(room.id!) : const drift.Value.absent(),
            name: drift.Value(room.name),
            description: drift.Value(room.description),
            type: drift.Value(room.type),
            dpUrl: drift.Value(await saveFileToLocalStorage(
                room.dpUrl.toString(), room.id.toString(), 'room_dp')),
            timestamp: drift.Value(room.timestamp),
            lastMessageTimestamp: drift.Value(room.lastMessageTimestamp),
            unreadMessages: drift.Value(room.unreadMessages),
            userLastSeen: drift.Value(room.userLastSeen),
            isSynced: const drift.Value(true));
        _apiRoomData?.add(roomCompanion);
        await db.insertRoomToDB(roomCompanion);
        fetchRoomMembersAndStoreInDB(db, room.id.toString());
      }
      // logger.d("Saved All Rooms to Local DB");
    } catch (e) {
      logger.e('Error saving rooms to local DB: $e');
    }
    return null;
  }

  //-----------------------------------------------------fetch RoomData FromLocalDB------------------------------------------------------//

  Future<List<Rooms>> fetchRoomDataFromLocalDB(AppDb db) async {
    // print("Fetching from local Storage");

    try {
      List<Room> temp = await db.getAllProjectsDB();
      List<Rooms> userProjectData;
      userProjectData = temp.map((room) {
        return Rooms(
          id: room.id,
          name: room.name,
          description: room.description,
          type: room.type,
          dpUrl: room.dpUrl,
          timestamp: room.timestamp,
          lastMessageTimestamp: room.lastMessageTimestamp,
          unreadMessages: room.unreadMessages,
          userLastSeen: room.userLastSeen,
        );
      }).toList();

      return userProjectData;
    } catch (e) {
      logger.e("Error fetching room data: $e");
      return [];
    }
  }

  Future<List<Rooms>> fetchAnnouncementDataFromLocalDB(db) async {
    // print("Fetching Announcement from local Storage");

    try {
      // Fetch the raw data from local database
      List<Room> temp = await db.getAllAnnouncementsDB();
      List<Rooms> announcementData;
      // Map the fetched data to Rooms objects
      logger.t("Fetched Announcement data: $temp");
      announcementData = temp.map((room) {
        return Rooms(
          id: room.id,
          name: room.name,
          description: room.description,
          type: room.type,
          dpUrl: room.dpUrl,
          timestamp: room.timestamp,
          lastMessageTimestamp: room.lastMessageTimestamp,
          unreadMessages: room.unreadMessages,
          userLastSeen: room.userLastSeen,
        );
      }).toList();
      logger.t("annoucement length:${announcementData.length}");
      // _isRoomLoaded = true; //this will help chatScreen for data available or not
      return announcementData;
    } catch (e) {
      logger.e("Error fetching room data: $e");
      return [];
    }
  }

  //-------PIPELINE:1.localDBfetch -->fetchFromApi -->updateLocalDBwithNewData --> UpdateUI ------------------------------------------//
  ///STAGE 1:localDB
  Future<void> fetchAllRoomDataFromLocalDB(AppDb db) async {
    try {
      allrooms = await fetchRoomDataFromLocalDB(db);
      userProjects = allrooms
              ?.where((room) => room.type != "workshop")
              .toList()
              .cast<Rooms>() ??
          [];
      userWorkshop = allrooms
              ?.where((room) => room.type == "workshop")
              .toList()
              .cast<Rooms>() ??
          [];
      announcement = await fetchAnnouncementDataFromLocalDB(db);
    } catch (e) {
      logger.e("Error fetching data from local storage: $e");
    } finally {
      isRoomLoaded = true;
      notifyListeners();
    }
  }

  //-----------------------------------------------------fetch RoomData From  API------------------------------------------------------//

  Future<void> fetchAllRoomDataFromApiAndSyncWithDB(AppDb db) async {
    UserModel currUser = userProv.getUserInfo;
    String? email = currUser.email;
    try {
      //Fetch all Data and Render
      announcement = email != null ? await chatP.fetchAnnouncement(email) : [];
      allrooms = email != null ? await chatP.fetchRooms(email) : [];

      userProjects = allrooms
              ?.where((room) => room.type != "workshop")
              .toList()
              .cast<Rooms>() ??
          [];
      userWorkshop = allrooms
              ?.where((room) => room.type == "workshop")
              .toList()
              .cast<Rooms>() ??
          [];

      //Overwrite in DB and refetch from db
      await saveRoomsToLocalDb(announcement, db);
      await saveRoomsToLocalDb(allrooms, db);
      fetchAllRoomDataFromLocalDB(db);

      // logger.d("Fetched And Saved All Room info");
    } catch (e) {
      logger.e(e);
    }
  }

  // ---------------------------------------------------messageDataSavingAndFetching--------------------------------------------------//

  Future<void> workerToSaveMessages(
      List<MessageModel> messages, AppDb db, String messageRoomId) async {
    try {
      // Use a single transaction for processing all messages
      await db.transaction(() async {
        for (final message in messages) {
          // Handle poll data
          if (message.poll != null) {
            final pollCompanion = PollTableCompanion(
              id: drift.Value(message.id!),
              title: drift.Value(message.poll!.title),
              description: drift.Value(message.poll!.description),
              lastVoted: drift.Value(message.poll!.lastVoted),
            );

            // Insert poll data
            await db.into(db.pollTable).insertOnConflictUpdate(pollCompanion);

            // Insert poll options
            for (var option in message.poll!.pollOptions) {
              final pollOptionCompanion = PollOptionTableCompanion(
                id: drift.Value(option.id),
                pollId: drift.Value(message.id!),
                value: drift.Value(option.value),
                numVotes: drift.Value(option.numVotes),
                voterId: option.voterIds != null &&
                        option.voterIds!.contains(userProv.getUserInfo.id)
                    ? const drift.Value(true)
                    : const drift.Value(false),
              );

              await db
                  .into(db.pollOptionTable)
                  .insertOnConflictUpdate(pollOptionCompanion);
            }
          }

          // Handle file data
          if (message.file?.uri != null && message.file?.uri.toString() != "") {
            try {
              // Save the file locally (async operation)
              saveFileToLocalStorage(message.file!.uri.toString(),
                  message.file!.name, 'room_file');

              // Store the file data in the database
              final fileCompanion = FileTableCompanion(
                id: drift.Value(message.id),
                uri: drift.Value(message.file!.uri.toString()),
                name: drift.Value(message.file!.name),
                filePath: drift.Value(
                    await getFilePath(message.file!.name, 'room_file')),
              );

              await db.into(db.fileTable).insertOnConflictUpdate(fileCompanion);
            } catch (e) {
              logger.e("ERROR on saving file to DB: $e");
            }
          }

          // Handle room member data
          try {
            final roomMemberCompanion = RoomMemberTableCompanion(
              id: drift.Value(message.sender!.id),
              name: drift.Value(message.sender?.name ?? ""),
            );

            await db
                .into(db.roomMemberTable)
                .insertOnConflictUpdate(roomMemberCompanion);
          } catch (e) {
            logger.e("ERROR saving room member details: $e");
          }

          // Handle message data
          final messageCompanion = MessagesTableCompanion(
            id: message.id != null
                ? drift.Value(message.id!)
                : const drift.Value.absent(),
            type: drift.Value(message.type.toString().split('.').last),
            timestamp: drift.Value(message.timestamp!.millisecondsSinceEpoch),
            sentFromId: message.sender?.id != null
                ? drift.Value(message.sender!.id)
                : const drift.Value.absent(),
            replyToId: message.replyToId != null
                ? drift.Value(message.replyToId)
                : const drift.Value.absent(),
            isSynced: const drift.Value(true),
            textData: message.type == MessageType.text && message.text != null
                ? drift.Value(message.text!.content)
                : const drift.Value.absent(),
            pollId: message.type == MessageType.poll && message.id != null
                ? drift.Value(message.id!)
                : const drift.Value.absent(),
            fileId: message.type == MessageType.file && message.id != null
                ? drift.Value(message.id!)
                : const drift.Value.absent(),
            roomId: drift.Value(int.parse(messageRoomId.toString())),
          );

          // Insert or update message data
          await db
              .into(db.messagesTable)
              .insertOnConflictUpdate(messageCompanion);
        }
      });
    } catch (e) {
      logger.e("Error saving messages: $e");
    }
  }

  //--------------------------------------------------fetchAllMessage-----------------------------------------------//

  // ignore: non_constant_identifier_names
  Future<void> fetchAllMessagesFromAPI_andStoreInDB(
      AppDb db, String roomID) async {
    try {
      loadingAPIMessages = true;
      List<MessageResponseModel>? allMessages = await chatP.getChatMessages(roomID) ;
      loadingAPIMessages = false;
      if (allMessages.isEmpty) {
        return;
      }
      logger.d("Fetched Messages from API");
      if (roomID == currRoomId) {
        List<MessageModel> messageModels =
            allMessages.map((message) => message.toModel()).toList();
        await workerToSaveMessages(messageModels, db, roomID);
      }
    } catch (e) {
      logger.e('Error saving message to local DB: $e');
    }
  }

  //--------------------------------------------------fetchAllMessageOfRoomFromLocalDB-----------------------------------------------//
  //Optimized Fetch Call
  Future<List<MessageModel>> fetchAllMessagesFromLocalDB(
      AppDb db, String roomID) async {
    try {
      // Step 1: Fetch messages and associated sender details in a single query
      final messageQuery = db.select(db.messagesTable).join([
        leftOuterJoin(
          db.roomMemberTable,
          db.messagesTable.sentFromId.equalsExp(db.roomMemberTable.id),
        ),
      ])
        ..where(db.messagesTable.roomId.equals(int.parse(roomID)));

      final results = await messageQuery.get();

      // Step 2: Extract all message IDs to batch-fetch associated data
      final messageIds =
          results.map((row) => row.readTable(db.messagesTable).id).toList();

      // Fetch poll data for all messages in a single query
      final polls = await (db.select(db.pollTable)
            ..where((tbl) => tbl.id.isIn(messageIds)))
          .get();
      final pollMap = {for (var poll in polls) poll.id: poll};

      // Fetch poll options for all messages in a single query
      final pollOptions = await (db.select(db.pollOptionTable)
            ..where((tbl) => tbl.pollId.isIn(messageIds)))
          .get();
      final pollOptionMap = <int, List<PollOption>>{};
      for (var option in pollOptions) {
        pollOptionMap.putIfAbsent(option.pollId, () => []).add(
              PollOption(
                id: option.id,
                value: option.value,
                numVotes: option.numVotes,
                voterIds:
                    option.voterId == true ? [userProv.getUserInfo.id!] : [],
              ),
            );
      }

      // Fetch file data for all messages in a single query
      final files = await (db.select(db.fileTable)
            ..where((tbl) => tbl.id.isIn(messageIds)))
          .get();
      final fileMap = {for (var file in files) file.id: file};

      // Step 3: Construct MessageModel list
      List<MessageModel> messages = [];
      for (final row in results) {
        final message = row.readTable(db.messagesTable);
        final user = row.readTableOrNull(db.roomMemberTable);

        // Retrieve poll and poll options
        final pollData = pollMap[message.id];
        final pollOptionsData = pollOptionMap[message.id] ?? [];

        final poll = pollData != null
            ? PollData(
                title: pollData.title,
                description: pollData.description!,
                pollOptions: pollOptionsData,
                lastVoted: pollData.lastVoted,
              )
            : null;

        // Retrieve file data
        final fileData = fileMap[message.id];
        final file = fileData != null
            ? FileData(
                uri: Uri.parse(fileData.uri),
                filePath: fileData.filePath ?? "",
                description: fileData.description,
                name: fileData.name,
              )
            : null;

        // Create MessageModel
        final tempMessage = MessageModel(
          id: message.id,
          type: MessageType.values.byName(message.type!),
          text: TextData(content: message.textData),
          file: file,
          poll: poll,
          sender: user != null
              ? Sender(
                  id: user.id,
                  name: user.name,
                  dp: user.dpUrl,
                )
              : null,
          timestamp: message.timestamp != null
              ? DateTime.fromMillisecondsSinceEpoch(message.timestamp!)
              : null,
          replyToId: message.replyToId,
        );

        messages.add(tempMessage);
      }

      return messages;
    } catch (e) {
      logger.e('Error fetching messages from local DB: $e');
      return [];
    } finally {
      notifyListeners();
    }
  }

  ///-----------------PIPELINE:FOR MESSAGE--------------------///
  ///Step1:fetching from localDB and displaying on UI
  ///Step2:fetching from Api and update localDB.
  Future<void> staticMessagePipeline(AppDb db, String roomID) async {
    // logger.i("..Message pipeline started... for $roomID");

    try {
      messages = await fetchAllMessagesFromLocalDB(db, roomID);
      // assignGlobalKeystoMessages();
      // logger.i("Message Pipeline STAGE 1 for $roomID");
    } catch (e) {
      logger.e("Error in stage1:messagePIPELINE: $e");
    } finally {
      messages = List.from(messages);
      notifyListeners();
    }

    try {
      logger.i("Message Pipeline STAGE 2");
      await fetchAllMessagesFromAPI_andStoreInDB(db, roomID);
      logger.d("Fetched ALL APIs for $roomID");

      final newMessages = await fetchAllMessagesFromLocalDB(db, roomID);

      //Modify the whole List

      if (currRoomId == roomID) {
        messages = List.from(newMessages);
        // logger.d("Synced LocalDB from API for $roomID");
      }
    } catch (e) {
      logger.e("error in stage2:messagePIPLINE:$e");
    } finally {
      notifyListeners();
    }
  }

  ///Step3:dynamic message update 1.to local db 2.to UI (handle by websocket)

  //----------------------------------------------------------POLLS----------------------------------------------------//

  bool _isPollBeingCreated = false;

  bool get isPollBeingCreated => _isPollBeingCreated;
  set isPollBeingCreated(bool status) {
    _isPollBeingCreated = status;
    notifyListeners();
  }

  //----------------------------------------------------save the image url as image path-----------------------------------------------//

  Future<String> saveFileToLocalStorage(
      String fileUrl, String fileName, String fileType) async {
    // Validate URL
    if (fileUrl.isEmpty || !Uri.parse(fileUrl).isAbsolute) {
      return "";
    }

    try {
      // Make the HTTP request to fetch the file
      final sanitizedUrl = Uri.encodeFull(fileUrl.trim());
      final response = await http.get(Uri.parse(sanitizedUrl));

      // Check for successful response
      if (response.statusCode != 200) {
        throw Exception('Failed to load FILE from URL');
      }

      final fileBytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory();
      final userDirectoryPath = '${directory.path}/$fileType';
      final userDirectory = Directory(userDirectoryPath);
      if (!await userDirectory.exists()) {
        await userDirectory.create(
            recursive: true); // Ensure parent directories are created
      }

      // Construct the file path (use fileType extension)

      final filePath = '${userDirectory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(fileBytes);
      logger.d("File saved successfully at $filePath");
      return filePath;
    } on SocketException catch (e) {
      logger.e("Network error: $e");
      return "";
    } catch (e) {
      logger.e("Error saving file: $e");
      return "";
    }
  }

  Future<String> getFilePath(String fileName, String fileType) async {
    try {
      // Get the application directory
      final directory = await getApplicationDocumentsDirectory();

      // Construct the file path (use fileType extension)
      final filePath = '${directory.path}/$fileType/$fileName';
      return filePath;
    } catch (e) {
      logger.e("Error generating file path: $e");
      return "Error: $e";
    }
  }

  Widget showProfileImage(String imagePath,
      {double width = 50.0, height = 50.0, radius = 10.0}) {
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } catch (e) {
      logger.e("Error displaying profile image: $e");
      return const ClipOval(
        child: Icon(
          Icons.person,
          size: 40,
          color: Colors.grey,
        ),
      );
    }
  }

  Color _generateBackgroundColor(String name) {
    int hash = name.hashCode;
    int colorIndex = hash % Colors.primaries.length;
    return Colors.primaries[colorIndex];
  }

  Color _getContrastingTextColor(Color backgroundColor) {
    double luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  Widget customUserName(String? name, {double radius = 50.0}) {
    name = name ?? "zine";
    Color backgroundColor = _generateBackgroundColor(name);
    Color textColor = _getContrastingTextColor(backgroundColor);
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: 50,
          height: 50,
          color: _generateBackgroundColor(name).withValues(alpha: 0.8),
          child: Center(
            child: Text(
              name.substring(0, 1).toUpperCase(),
              style: TextStyle(
                  fontSize: 30, color: textColor, fontFamily: 'Poppins'),
            ),
          ),
        ));
  }

  void sendPollResponse(int messageId, int optionId) {
    if (!_client.connected) {
      logger.e("Not connected to the WebSocket server.");
      return;
    }

    final messageData = {
      "chatId": messageId,
      "voterId": userProv.getUserInfo.id!,
      "optionId": optionId,
    };
    int pollIndex = messages.indexWhere(
      (element) => element.id! == messageId,
    );

    if (messages[pollIndex].poll!.lastVoted != null) {
      // remove old vote and add new vote
      int optionIndex = messages[pollIndex].poll!.pollOptions.indexWhere(
          (option) => option.id == messages[pollIndex].poll!.lastVoted);

      messages[pollIndex].poll!.pollOptions[optionIndex].numVotes--;
    }

    messages[pollIndex].poll!.lastVoted = optionId;
    int optionIndex = messages[pollIndex].poll!.pollOptions.indexWhere(
          (element) => element.id == optionId,
        );
    messages[pollIndex].poll!.pollOptions[optionIndex].numVotes++;

    // _messageStreamController.add(messages);
    notifyListeners();

    final jsonBody = json.encode(messageData);
    logger.t('messageData: $messageData');

    try {
      _client.send(
        destination: "/app/poll-vote",
        body: jsonBody,
      );
      logger.i("Vote Sent.");
    } catch (e) {
      logger.e('Not connected to the WebSocket server.$e');
    }
  }

  void sendPoll(String title, List<String> options, String description) async {
    if (!_client.connected) {
      logger.e("Not connected to the WebSocket server.");
      return;
    }

    final messageData = {
      "type": "poll",
      "poll": {
        'title': title,
        'pollOptions': options,
        'description': description
      },
      "timestamp": DateTime.now()
          .millisecondsSinceEpoch, // or DateTime.now().toIso8601String()
      "sentFrom": userProv.getUserInfo.id!,
      "roomId": int.parse(currRoomId),
    };
    if (replyTo != null && replyUsername != null) {
      messageData['replyTo'] = replyTo;
    }
    final jsonBody = json.encode(messageData);
    logger.t('messageData: $messageData');
    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      logger.i("Poll Sent.");
    } catch (e) {
      logger.e('Not connected to the WebSocket server.$e');
    }
  }

  //===============================================FILES===========================================

  bool _isFileLoading = false;
  bool _isUploading = false;
  bool _isFileReady = false;

  String _fileUri = '';
  String _fileName = '';
  String _publicId = '';
  String _filePath = '';

  String get fileUri => _fileUri;
  String get fileName => _fileName;
  String get filePath => _filePath;

  bool get isFileLoading => _isFileLoading;
  bool get isUploading => _isUploading;
  bool get isFileReady => _isFileReady;

  void startFileSelect() async {
    _isFileLoading = true;
    notifyListeners();

    File? file = await pickFile();

    if (file != null) {
      Uri? fileUri = await uploadFileWithDescription(
          file: file, description: basename(file.path));

      if (fileUri == null) {
        Fluttertoast.showToast(
            msg: 'An Error Occured during upload',
            backgroundColor: Colors.red,
            textColor: Colors.white);
        _isFileLoading = false;
        notifyListeners();
      }

      _filePath = file.path;
      _fileUri = fileUri.toString();
      _fileName = basename(file.path);

      _isFileReady = true;
      notifyListeners();

      logger.d("Selected filename ${basename(file.path)}");
    } else {
      _isFileLoading = false;
      notifyListeners();
    }
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    var filePath = result?.files.single.path;
    logger.i("Picked File");
    logger.d("File path: $filePath");
    return result != null ? File(result.files.single.path!) : null;
  }

  Future<Uri?> uploadFileWithDescription({
    required File file,
    required String description,
  }) async {
    _isUploading = true;
    notifyListeners();
    try {
      // Create a MultipartRequest
      var request = http.MultipartRequest('POST', BackendProperties.uploadUri);

      // Attach the file as form-data
      var multipartFile = await http.MultipartFile.fromPath('file', file.path);
      request.files.add(multipartFile);

      // Attach the description as form-data
      request.fields['description'] = description;
      request.fields['folder'] = 'chat-file';

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        // Parse the response
        var responseBody = await http.Response.fromStream(response);
        var responseData = json.decode(responseBody.body);

        // Return the 'url' field if it exists

        if (responseData != null && responseData.containsKey('url')) {
          Uri url = Uri.parse(responseData['url']);
          logger.d("Got File url ${url.toString()}");
          _publicId = responseData['publicId'];
          return url;
        } else {
          logger.e('Response does not contain a "url" field');
          return null;
        }
      } else {
        throw Exception(
            'File upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error uploading file: $e');
      return null;
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }

  Future<void> cancelUpload() async {
    try {
      _fileName = '';
      _fileUri = '';
      _isFileReady = false;
      _isFileLoading = false;
      notifyListeners();
      final response =
          await http.post(BackendProperties.deleteUpload(_publicId));
      if (response.statusCode != 200) {
        throw Exception('Failed with status code: ${response.statusCode}');
      }
      logger.d('File Deleted.');
    } catch (e) {
      logger.w(
          'Cancel Upload Failed. File is probably not deleted from backend: $e');
    }
  }

  void sendFile(String description) async {
    if (!_client.connected) {

        logger.e("Not connected to the WebSocket server.");

      return;
    }

    final messageData = {
      "type": "file",
      'file': {'url': _fileUri, 'description': description, 'name': _fileName},
      "timestamp": DateTime.now()
          .millisecondsSinceEpoch, // or DateTime.now().toIso8601String()
      "sentFrom": userProv.getUserInfo.id!,
      "roomId": int.parse(currRoomId),
    };
    if (replyTo != null && replyUsername != null) {
      messageData['replyTo'] = replyTo;
    }
    final jsonBody = json.encode(messageData);

    logger.t('messageData: $messageData');
    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      logger.d('Message Sent');
    } catch (e) {
      logger.e('Not connected to the WebSocket server.$e');
    }
    _fileName = '';
    _fileUri = '';
    _isFileReady = false;
    _isFileLoading = false;
    notifyListeners();
  }

  //=====================================================older code===================================================================//

  void addRouteListener(
      BuildContext context, var room, var user, UserProv userProv) {

    ModalRoute.of(context)?.popped.then((_) {
      updateUnreadMessagesToZero(currRoomId);
    });
  }

  void disconnect() {
    for (var roomId in _subscriptions.keys) {
      unsubscribeFromRoom(roomId);
    }
    _client.deactivate();
    isConnected = false;
  }

  @override
  void dispose() {
    disconnect(); // Ensure clean-up on disposal
    messages = [];
    updateUnreadMessagesToZero(currRoomId);

    super.dispose();
  }
}
