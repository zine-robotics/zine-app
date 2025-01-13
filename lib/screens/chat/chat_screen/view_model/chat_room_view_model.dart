import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
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
  Map<String, dynamic> _subscriptions = {};

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
  final CollectionReference _rooms =
      FirebaseFirestore.instance.collection('rooms');

  //-------------------------------------------------message fetching using http--------------------//
  List<MessageModel> messages = [];
  Map<String, RoomMemberModel> currentRoomMembers = {};
  bool _isLoaded = false; //It should be true at
  bool _isError = false;
  bool _isNewRoomData = false; //track new Room data

  Set<String> activeRoomSubscriptions = {};

  bool get isLoaded => _isLoaded;
  bool get isError => _isError;
  bool get isNewRoomData => _isNewRoomData;

  //-------------------------------------------------------------stomp_client-----------------------------------------//

  late StompClient _client;

  bool isConnected = false;

  // late final messageData;

  void initializeWebSocket() {
    String uid = userProv.getUserInfo.uid!;
    print("\n----------initializing web socket------------\n ");
    _client = StompClient(
      config: StompConfig(
        useSockJS: true,
        url: BackendProperties.websocketUri.toString(),
        onConnect: onConnectCallback,
        stompConnectHeaders: {"Authorization": uid},
        onWebSocketError: (dynamic error) => print('WebSocket error: $error'),
        // onDebugMessage: (dynamic message) => print('Debug: $message'),
      ),
    );
    print("Activating WebSocket client");
    _client.activate();
  }

  void onConnectCallback(StompFrame connectFrame) {
    isConnected = true;
    print("inside the callback");
  }

  void subscribeToActiveMember(String currRoomID, AppDb db) {
    final subscription = _client.subscribe(
        destination: "/room/$currRoomID/active-users",
        // headers: BackendProperties.getHeaders(),
        headers: {"roomId": currRoomID},
        callback: (StompFrame frame) async {
          try {
            // _activeMembers = [];
            final List<dynamic> activeMemberData = json.decode(frame.body!);
            final List<String> activeMemberList =
                activeMemberData.map((item) => item.toString()).toList();
            // logger.d(
            //     "\n newly created websocket acive user data:${activeMemberList}");
            List<RoomMemberModel>? roomMemberData =
                await fetchRoomMemberDetailsFromLocalDb(db, activeMemberList);

            // _activeMembers = List<RoomMemberModel>.from(roomMemberData ?? []);
            currentRoomMembers =
                await db.getRoomMembersByRoomId(int.parse(currRoomID));
            currentRoomMembers.forEach((key, value) {
              if (activeMemberList.contains(value.email)) {
                value.isActive = true;
                print("Active Member: ${value.name}");
                logger.d("Active Member: ${value.name}");
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
          // logger.i("Received message: $messageData");
          MessageUpdateResponseModel messageRecieved =
              MessageUpdateResponseModel.fromJson(messageData);

          print(
              "Timestamp Local ${messageRecieved.body!.timestamp!.toLocal()}");
          print("Timestamp UTC ${messageRecieved.body!.timestamp!}");
          messageRecieved.body!.timestamp =
              messageRecieved.body!.timestamp!.toLocal();
          MessageModel? roomMessage;

          if (messageRecieved.update == 'poll-update' &&
              messageRecieved.pollUpdate != null) {
            //Handle Poll Update
            int pollIndex = messages.indexWhere(
              (element) =>
                  element.id! == messageRecieved.pollUpdate!.chatItemId,
            );
            messages[pollIndex].poll!.pollOptions =
                messageRecieved.pollUpdate!.pollOptions;

            roomMessage = messages[pollIndex];
          } else if (messageRecieved.update == 'new-message' &&
              messageRecieved.body != null) {
            roomMessage = messageRecieved.toModel();
            messages.add(roomMessage);
          }
          notifyListeners();
          await workerToSaveMessage(roomMessage!, db, roomId);

          // logger.d("Socket Callback New Message - Over");
        } catch (e) {
          logger.e(e);
        } finally {
          notifyListeners();
        }
        // messages = jsonDecode(frame.body!).reversed.toList();
        // Notify listeners or update UI
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
    // logger.i("attempting to unsubscribe roomId:$roomId");
    final subscription = _subscriptions[roomId];
    if (subscription != null) {
      try {
        // subscription.unsubscribe(unsubscribeHeaders: {});
        subscription();
        print("Unsubscribed from room: $roomId");
      } catch (e) {
        print("Error unsubscribing from room $roomId: $e");
      } finally {
        _subscriptions.remove(roomId);
      }
    } else {
      print("No active subscription found for room: $roomId");
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

  void sendMessage(String user_message, String roomName) async {
    // int? roomId=roomNameToId[roomName];
    if (!_client.connected) {
      print("Not connected to the WebSocket server.");
      return;
    }

    final messageData = {
      "type": "text",
      "sentFrom": userProv.getUserInfo.id!,
      "roomId": int.parse(currRoomId),
      "text": {"content": user_message.trim()},
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
      print("\n-------message Sent--------\n");
    } catch (e) {
      print('Not connected to the WebSocket server.$e');
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
  int _allChatRoom = 0;
  get allChatRoom => _allChatRoom;
  var fMessaging = FirebaseMessaging.instance;

  void userReplyText(MessageModel message) {
    // print("inside the userReplyText");
    print(message);

    selectedReplyMessage = message;
    replyTo = message.id;
    replyUsername = message.sender!.name.toString();
    print("reply in user Reply:${replyTo.runtimeType}");

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
  dynamic updateSeen(String email_id, String room_id, DateTime userLastSeen,
      DateTime lastMessageTimestamp, int unreadMessages) async {
    Uri url = BackendProperties.updateLastSeenUri(email_id, room_id);
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
        // print("seen for room:$room_id updated");
      } else {
        print("error occure:During put operation");
      }
    } catch (e) {
      print("some error During put operation:$e");
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
  List<RoomMemberModel>? _activeMembers = [];
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
      if (allRoomMembers != null && allRoomMembers.isNotEmpty) {
        await db.batch((batch) async {
          for (RoomMemberModel roomMember in allRoomMembers) {
            final roomMemberCompanion = RoomMemberTableCompanion(
              name: drift.Value(roomMember.name ?? "anonymous"),
              email: drift.Value(roomMember.email ?? "random@gmail.com"),
              role: drift.Value(roomMember.role ?? "user"),
              id: drift.Value(roomMember.id),
              dpUrl: drift.Value(
                await saveImageToLocalStorage(
                  roomMember.dpUrl.toString() ?? "",
                  roomMember.id.toString(),
                  roomMember.name ?? "",
                ),
              ),
            );
            batch.insert(
              db.roomMemberTable,
              roomMemberCompanion,
              mode: InsertMode.replace,
            );
          }
        });
      }
    } catch (e) {
      logger.e("ERROR in saveRoomMemberToLocalDb: $e");
    }
  }

  void updateUnreadMessagesToZero(String roomId) async {
    print("inside the updateUnreadMessagesToZero");
    allrooms = allrooms?.map((room) {
      if (room.id.toString() == roomId) {
        room.unreadMessages = 0;
        print("inside $roomId  to Zero");
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
  List<Room>? _toDeleteRoomData;

  Future<List<Rooms>?> saveRoomsToLocalDb(
      List<Rooms>? allRooms, AppDb db) async {
    try {
      for (Rooms room in allRooms!) {
        final roomCompanion = RoomsTableCompanion(
            id: room.id != null ? drift.Value(room.id!) : drift.Value.absent(),
            name: drift.Value(room.name),
            description: drift.Value(room.description),
            type: drift.Value(room.type),
            dpUrl: drift.Value(await saveImageToLocalStorage(
                room.dpUrl.toString(),
                room.id.toString(),
                room.name.toString())),
            timestamp: drift.Value(room.timestamp),
            lastMessageTimestamp: drift.Value(room.lastMessageTimestamp),
            unreadMessages: drift.Value(room.unreadMessages),
            userLastSeen: drift.Value(room.userLastSeen),
            isSynced: drift.Value(true));
        _apiRoomData?.add(roomCompanion);
        await db.insertRoomToDB(roomCompanion);
        fetchRoomMembersAndStoreInDB(db, room.id.toString());
      }
      // logger.d("Saved All Rooms to Local DB");
    } catch (e) {
      print('Error saving rooms to local DB: $e');
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
      print("Error fetching room data: $e");
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
      print("-----announcemnet data------------");
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
      print("annoucement length:${announcementData.length}");
      // _isRoomLoaded = true; //this will help chatScreen for data available or not
      return announcementData;
    } catch (e) {
      print("Error fetching room data: $e");
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
  //savingAllStaticMessageFromAPi

  //Have to change this, very unoptimized
  Future<void> workerToSaveMessage(
      MessageModel message, db, String messageRoomId) async {
    // Use a transaction and batch to ensure atomicity and improve performance
    try {
      await db.transaction(() async {
        // Saving poll data and poll option data inside a batch
        if (message.poll != null) {
          final pollCompanion = PollTableCompanion(
            id: drift.Value(message.id!),
            title: drift.Value(message.poll!.title),
            description: drift.Value(message.poll!.description),
            lastVoted: drift.Value(message.poll!.lastVoted),
          );
          print("message poll-lastvoted:${message.poll?.lastVoted}");

          // Insert poll data
          await db.into(db.pollTable).insertOnConflictUpdate(pollCompanion);

          // Insert poll options inside a batch
          //TODO: Change voter ID to list of voter IDS
          for (var option in message.poll!.pollOptions) {
            final pollOptionCompanion = PollOptionTableCompanion(
                id: drift.Value(option.id),
                pollId: drift.Value(message.id!),
                value: drift.Value(option.value),
                numVotes: drift.Value(option.numVotes),
                voterId: option.voterIds != null
                    ? option.voterIds!.contains(userProv.getUserInfo.id)
                        ? drift.Value(true)
                        : drift.Value(false)
                    : drift.Value(false));
            // if(option.voterIds !=null){
            //   option.voterIds!.forEach((i) {
            //     print("user id: $i and userprov id :${userProv.getUserInfo.id} bool ${option.voterIds!.contains(userProv.getUserInfo.id)} check ${drift.Value.absent}");
            //
            //   });
            // }
            // print("pollOptioncompanion:${pollOptionCompanion.voterId}");

            await db
                .into(db.pollOptionTable)
                .insertOnConflictUpdate(pollOptionCompanion);
            // print("Success: PollOptionCompanion saved!!");
          }
        }
        try {
          if (message.file?.uri != null && message.file?.uri != "") {
            final fileCompanion = FileTableCompanion(
              id: drift.Value(message.id),
              uri: drift.Value(await saveImageToLocalStorage(
                  message.file!.uri.toString(),
                  message.id.toString(),
                  message.file!.name.toString())),
              name: drift.Value(message.file!.name),
            );
            await db.into(db.fileTable).insertOnConflictUpdate(fileCompanion);
          }
        } catch (e) {
          print("ERROR on saving fileOnDB:$e");
        }
        try {
          final roomMemberCompanion = RoomMemberTableCompanion(
            id: drift.Value(message.sender!.id),
            name: drift.Value(message.sender?.name ?? ""),
          );
          await db
              .into(db.roomMemberTable)
              .insertOnConflictUpdate(roomMemberCompanion);
        } catch (e) {
          print("ERROR roomMember details saving:$e");
        }
        final messageCompanion = MessagesTableCompanion(
          id: message.id != null
              ? drift.Value(message.id!)
              : drift.Value.absent(),
          type: drift.Value(message.type.toString().split('.').last),
          timestamp: drift.Value(message.timestamp!.millisecondsSinceEpoch),
          sentFromId: message.sender?.id != null
              ? drift.Value(message.sender!.id!)
              : drift.Value.absent(),
          replyToId:
              drift.Value(message.replyToId != null ? message.replyToId : null),
          isSynced: drift.Value(true),
          textData: message.type == MessageType.text && message.text != null
              ? drift.Value(message.text!.content)
              : drift.Value.absent(),
          pollId: message.type == MessageType.poll && message.id != null
              ? drift.Value(message.id!)
              : drift.Value.absent(),
          fileId: message.type == MessageType.file && message.id != null
              ? drift.Value(message.id!)
              : drift.Value.absent(),
          roomId: drift.Value(int.parse(messageRoomId.toString())),
        );
        // Insert or update message data
        await db
            .into(db.messagesTable)
            .insertOnConflictUpdate(messageCompanion);
        // print("Success: MessageCompanion saved!");
      });
    } catch (e) {
      print("Error saving poll/message data: $e");
    }
  }

  Future<void> fetchAllMessagesFromAPI_andStoreInDB(
      AppDb db, String roomID) async {
    try {
      List<MessageResponseModel>? allMessages =
          roomID != null ? await chatP.getChatMessages(roomID) : [];

      if (allMessages!.isEmpty) {
        return;
      }
      for (MessageResponseModel message in allMessages) {
        await workerToSaveMessage(message.toModel(), db, roomID);
      }
    } catch (e) {
      logger.e('Error saving message to local DB: $e');
    }
  }

  //--------------------------------------------------fetchAllMessageOfRoomFromLocalDB-----------------------------------------------//
  //Optimized Fetch Call
  Future<List<MessageModel>> fetchAllMessagesFromLocalDB(
      AppDb db, String roomID) async {
    // logger.d(
    // "----inside the fetching all message from local database and roomId is $roomID");
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
                id: option.id!,
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
      // logger.i("Message Pipeline STAGE 1 for $roomID");
    } catch (e) {
      logger.e("Error in stage1:messagePIPELINE: $e");
    } finally {
      messages = List.from(messages!);
      notifyListeners();
    }

    try {
      // logger.i("Message Pipeline STAGE 2");
      await fetchAllMessagesFromAPI_andStoreInDB(db, roomID);

      final newMessages = await fetchAllMessagesFromLocalDB(db, roomID);
      // logger.d("Fetched ALL APIs for $roomID");
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
  Future<String> saveImageToLocalStorage(
      String imageUrl, String userId, String fileName) async {
    if (imageUrl.isEmpty || !Uri.parse(imageUrl).isAbsolute) {
      return "";
    }
    bool isValidUrl(String url) {
      return Uri.tryParse(url)?.hasAbsolutePath ?? false;
    }

    if (!isValidUrl(imageUrl)) {}

    try {
      final sanitizedUrl = Uri.encodeFull(imageUrl.trim());
      final response = await http.get(Uri.parse(sanitizedUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to load image from URL');
      }
      final imageBytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory();
      final userDirectoryPath = '${directory.path}/$fileName/$userId';
      final userDirectory = Directory(userDirectoryPath);
      if (!await userDirectory.exists()) {
        await userDirectory.create(
            recursive: true); // Ensure parent directories are created
      }

      // Save image file
      final filePath = '${userDirectory.path}/dp.png';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      return filePath;
    } on SocketException catch (e) {
      print("Network error: $e");
      return "";
    } catch (e) {
      print("\nError during saving image to path: $e");
      return ""; // Return an empty string on failure
    }
  }

  // Writing a helper function to create DP
  Future<Widget> createDP(String userId, AppDb db,
      {double radius = 50.0}) async {
    // Fetch the USER object
    RoomMemberModel? user = await getRoomMember(db, userId);
    // Check if the DP file exists
    if (user!.dpUrl != null && File(user.dpUrl!).existsSync()) {
      return showProfileImage(user.dpUrl!,
          width: radius * 2, height: radius * 2, radius: radius);
    } else {
      return customUserName(user.name, radius: radius);
    }
  }

  Widget showProfileImage(String imagePath,
      {double width = 50.0, height = 50.0, radius = 10.0}) {
    // print("\n inside showProfileImage , imagePath:${imagePath}");
    try {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover, // Ensures the image covers the circle
          width: width, // Set to 2 * radius
          height: height, // Set to 2 * radius
        ),
      );
    } catch (e) {
      print("NO Valid filepath: $e");
      return ClipOval(
        child: Icon(
          Icons.person, // Error icon
          size: 40,
          color: Colors.grey,
        ),
      );
    }
  }

  Widget customUserName(String? name, {double radius = 50.0}) {
    // print("inside teh customUserName");
    name = name == null ? "zine" : name;
    return ClipRRect(
        borderRadius:
            BorderRadius.circular(radius), // Background color of the avatar
        child: Container(
          width: 50,
          height: 50,
          child: Center(
            child: Text(
              name.substring(0, 1).toUpperCase(), // Fallback text
              style: TextStyle(
                // fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.grey, // Text color
              ),
            ),
          ),
        ));
  }

  void sendPollResponse(int messageId, int optionId) {
    if (!_client.connected) {
      if (kDebugMode) {
        print("Not connected to the WebSocket server.");
      }
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
    print(
        "_messages LastVoted updated to ${messages[pollIndex].poll!.lastVoted}");
    int optionIndex = messages[pollIndex].poll!.pollOptions.indexWhere(
          (element) => element.id == optionId,
        );
    messages[pollIndex].poll!.pollOptions[optionIndex].numVotes++;

    // _messageStreamController.add(messages);
    notifyListeners();

    final jsonBody = json.encode(messageData);
    if (kDebugMode) {
      print("Send Poll update $jsonBody");
    }

    try {
      _client.send(
        destination: "/app/poll-vote",
        body: jsonBody,
      );
      if (kDebugMode) {
        print("\n-------poll update Sent--------\n");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Not connected to the WebSocket server.$e');
      }
    }
  }

  void sendPoll(String title, List<String> options, String description) async {
    if (!_client.connected) {
      if (kDebugMode) {
        print("Not connected to the WebSocket server.");
      }
      return;
    }

    final messageData = {
      "type": "poll",
      "poll": {
        'title': title,
        'pollOptions': options,
        'description': description ?? ''
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
    if (kDebugMode) {
      print("Send Poll body $jsonBody");
    }

    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      if (kDebugMode) {
        print("\n-------poll Sent--------\n");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Not connected to the WebSocket server.$e');
      }
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

      print("Selected filename ${basename(file.path)}");
    } else {
      _isFileLoading = false;
      notifyListeners();
    }
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

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
          if (kDebugMode) {
            print("Got File url ${url.toString()}");
          }
          _publicId = responseData['publicId'];
          return url;
        } else {
          if (kDebugMode) {
            print('Response does not contain a "url" field');
          }
          return null;
        }
      } else {
        throw Exception(
            'File upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      if (kDebugMode) {
        print('Error uploading file: $e');
      }
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
    } catch (e) {
      print('Error occurred: $e');
      return null; // Return null or handle the error as needed
    }
  }

  void sendFile(String description) async {
    if (!_client.connected) {
      if (kDebugMode) {
        print("Not connected to the WebSocket server.");
      }
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
    if (kDebugMode) {
      print("Send Poll body $jsonBody");
    }

    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      if (kDebugMode) {
        print("\n-------File Sent--------\n");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Not connected to the WebSocket server.$e');
      }
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
    ModalRoute.of(context)?.addScopedWillPopCallback(() {
      // roomLeft(room, user, userProv);
      updateUnreadMessagesToZero(currRoomId);
      return Future.value(true);
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
