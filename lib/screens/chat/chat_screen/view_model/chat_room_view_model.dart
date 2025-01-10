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
import 'package:zineapp2023/models/newUser.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/backend_properties.dart';

import '../../../../models/events.dart';
import '../../../../models/rooms.dart';
import '../repo/chat_repo.dart';
import 'package:http/http.dart' as http;
import 'package:zineapp2023/database/database.dart';
import 'package:drift/drift.dart' as drift;

class ChatRoomViewModel extends ChangeNotifier {
  final UserProv userProv;

  ChatRoomViewModel({required this.userProv}) {
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

  String _roomId = "625";
  final name = "Announcement";
  Map<String, dynamic> chatSubscription = {};
  final picker = ImagePicker();
  late MessageModel selectedReplyMessage;

  get roomId => _roomId;
  Map<String, Timestamp> lastChats = {};
  final CollectionReference _rooms =
      FirebaseFirestore.instance.collection('rooms');

  //-------------------------------------------------message fetching using http--------------------//
  List<MessageModel> messages = [];
  bool _isLoaded = false; //It should be true at
  bool _isError = false;
  bool _isNewRoomData = false; //track new Room data
  final StreamController<List<MessageModel>> _messageStreamController =
      StreamController<List<MessageModel>>.broadcast();
  // List<MessageModel> get messages => _messages;
  Set<String> activeRoomSubscriptions = {};

  bool get isLoaded => _isLoaded;
  bool get isError => _isError;
  bool get isNewRoomData => _isNewRoomData;
  Stream<List<MessageModel>> get messageStream =>
      _messageStreamController.stream;
  Future<void> fetchMessages(String TemproomId) async {
    try {
      messages = await chatP.getChatMessages(
          tempRoomId: TemproomId, uid: userProv.getUserInfo!.uid!);
      _messageStreamController.add(messages);
    } catch (e) {
      print(e);
      _messageStreamController.addError('Failed to load data');
      _isError = true;
      // _error ='Failed to load data';
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

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
        callback: (StompFrame frame) async {
          try {
            _activeMembers = [];
            final List<dynamic> activeMemberData = json.decode(frame.body!);
            final List<String> activeMemberList =
                activeMemberData.map((item) => item.toString()).toList();
            print(
                "\n newly created websocket acive user data:${activeMemberData}");
            List<RoomMemberModel>? roomMemberData =
                await fetchRoomMemberDetailsFromLocalDb(db, activeMemberList);
            _activeMembers = List<RoomMemberModel>.from(roomMemberData ?? []);
            notifyListeners();
          } catch (e) {
            print("ERROR:subscribeToActiveMemeber: $e");
          }
        });
  }

  void subscribeToRoom(String roomId, AppDb db) {
    if (!_client.connected) {
      print("client is not connected");
      return;
    }
    activeRoomSubscriptions.add(roomId);
    final subscription = _client.subscribe(
      destination: '/room/$roomId', //  widget.chatId
      headers: {'roomId': roomId}, //BackendProperties.getHeaders(),
      callback: (StompFrame frame) async {
        try {
          final Map<String, dynamic> messageData = json.decode(frame.body!);
          if (messageData['update'] == 'poll-update' &&
              messageData['pollUpdate'] != null) {
            if (kDebugMode) {
              print("PollUpdate Received $messageData");
            }
            Map<String, dynamic> pollUpdate = messageData['pollUpdate'];
            int pollIndex = messages.indexWhere(
              (element) => element.id! == pollUpdate['chatItemId'],
            );

            messages[pollIndex].poll!.pollOptions =
                (pollUpdate['pollOptions'] as List)
                    .map((e) => PollOption.fromJson(e))
                    .toList();
            _messageStreamController.add(messages);
          }

          if (messageData['update'] == 'new-message' &&
              messageData['body'] != null) {
            // if (kDebugMode) {
            //   print("New Message");
            //   print("===========================MESSAGE================");
            //   print(messageData);
            //   print("===============================================");
            // }
            MessageModel messageData1 =
                MessageModel.fromJson(messageData['body']);
            await workerToSaveMessage(messageData1, db, roomId);
            messages.add(messageData1);
          }
          _messageStreamController.add(List.from(messages));

          print("success!!");
        } catch (e) {
          // if (kDebugMode) {
          //   print("\n error parsing messaging :${e} \n");
          //   print("===================== RECEIVED DATA===================");
          //   print(jsonDecode(frame.body!));
          //   print("=======================================================");
          // }
        } finally {
          notifyListeners();
        }
        // messages = jsonDecode(frame.body!).reversed.toList();
        // Notify listeners or update UI
      },
    );

    _subscriptions[roomId] = subscription;
    _roomId = roomId;
  }

  //---------------------------------------------MODIFY: ADD multiple subscribtion->----------------//
  void unsubscribeFromRoom(String roomId) {
    print("attempting to unsubscribe roomId:$roomId");
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
    if (_roomId != roomId) {
      unsubscribeFromRoom(_roomId);
      _roomId = roomId;
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
      "roomId": int.parse(_roomId),
      "text": {"content": user_message.trim()}
    };
    if (replyTo != null && replyUsername != null) {
      messageData['replyTo'] = replyTo;
    }
    // print("during sent replyTo:$replyTo \t replyusername:$replyUsername");
    final jsonBody = json.encode(messageData);
    notifyListeners();
    try {
      _client.send(
        destination: "/app/message",
        body: jsonBody,
      );
      print("\n-------message Sent--------\n");
    } catch (e) {
      print('Not connected to the WebSocket server.$e');
    }
  }

  //-------------------------------------------------it will fetch all room data---------------------------------------------//

  List<Rooms>? _userProjects;
  List<Rooms>? _userWorkshop;
  List<Rooms>? _announcement;
  bool _isRoomLoaded = false;

  List<Rooms>? get userProjects => _userProjects;
  List<Rooms>? get userWorkshop => _userWorkshop;
  List<Rooms>? get announcement => _announcement;
  bool get isRoomLoaded => _isRoomLoaded;
  int _allChatRoom = 0;
  get allChatRoom => _allChatRoom;
  var fMessaging = FirebaseMessaging.instance;

  Future<void> loadRooms() async {
    UserModel currUser = userProv.getUserInfo;
    String email = currUser.email
        .toString(); //currUser.email.toString();  //FIXME : Fix this

    try {
      List<Rooms>? allRooms = await chatP.fetchRooms(email);
      List<Rooms>? allAnnouncment = await chatP.fetchAnnouncement(email);
      if (allRooms != null) {
        for (Rooms room in allRooms) {
          print('Subscribing to room${room.id}');
          fMessaging.subscribeToTopic("room${room.id}");
        }

        _userProjects = allRooms
            .where((room) => room.type == "group" || room.type == "project")
            .toList();
        _userWorkshop =
            allRooms.where((room) => room.type == "workshop").toList();
        _announcement = allAnnouncment;
        _allChatRoom = _userWorkshop!.length +
            _announcement!.length +
            _userProjects!.length;
        if (kDebugMode) {
          print("announcement:${_announcement}");
        }
        notifyListeners();
      }

      _isRoomLoaded = true;
    } catch (e) {
      print("load_room:$e");
      // _error ='Failed to load data';
    } finally {
      notifyListeners();
    }
  }

  void userReplyText(MessageModel message) {
    // print("inside the userReplyText");
    print(message);

    selectedReplyMessage = message;
    replyTo = message.id;
    replyUsername = message.sentFrom!.name.toString();
    // print("reply in user Reply:${replyTo.runtimeType}");

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
  Future<void> saveRoomMemberToLocalDb(
      AppDb db, List<String>? allRoomIDs) async {
    print("inside teh saveRoomMember");
    try {
      if (allRoomIDs != null) {
        for (String roomId in allRoomIDs) {
          List<RoomMemberModel>? allRoomMembers =
              await chatP.fetchTotalActiveMember(roomId);
          if (allRoomMembers != null && allRoomMembers.isNotEmpty) {
            await db.batch((batch) async {
              for (RoomMemberModel roomMember in allRoomMembers) {
                final roomMemberCompanion = RoomMemberTableCompanion(
                  name: drift.Value(roomMember.name ?? ""),
                  email: drift.Value(roomMember.email ?? ""),
                  role: drift.Value(roomMember.role),
                  dpUrl: drift.Value(
                    await saveImageToLocalStorage(
                      roomMember.dpUrl.toString() ?? "",
                      roomMember.name ?? "",
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
        }
      }
      print("Completed");
      notifyListeners();
    } catch (e) {
      print("ERROR in saveRoomMemberToLocalDb: $e");
    }
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
  static List<RoomsTableCompanion>? _apiAnnouncementData;
  List<Room>? _toDeleteRoomData;

  Future<List<Rooms>?> saveRoomsToLocalDb(AppDb db) async {
    UserModel currUser = userProv.getUserInfo;
    String? email = currUser.email;
    try {
      List<Rooms>? allRooms =
          email != null ? await chatP.fetchRooms(email!) : [];
      List<String>? allRoomIds = allRooms
          ?.map((option) => option.id.toString())
          .cast<String>()
          .toList();
      saveRoomMemberToLocalDb(db, allRoomIds);
      if (allRooms!.isEmpty) {
        return []; // Exit the function if no rooms to save
      }
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
      }
      return allRooms;
    } catch (e) {
      print('Error saving rooms to local DB: $e');
    }
  }
  //-----------------------------------------------------fetchRoomDataFromLocalDB------------------------------------------------------//

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

  //----------------------------------------------------saveAnnouncementToLocalStorage------------------------------------------------//
  Future<List<Rooms>?> saveAnnouncementToLocalDb(AppDb db) async {
    UserModel currUser = userProv.getUserInfo;
    String? email = currUser.email;
    try {
      List<Rooms>? allRooms =
          email != null ? await chatP.fetchAnnouncement(email!) : [];
      if (allRooms!.isEmpty) {
        return [];
      }
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
        _apiAnnouncementData?.add(roomCompanion);
        await db.insertRoomToDB(roomCompanion);
      }
      return allRooms;
    } catch (e) {
      print('Error saving Announcement to local DB: $e');
    }
  }
  //-----------------------------------------------------fetchAnnoucementDataFromLocalDB------------------------------------------------------//

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

      _isRoomLoaded =
          true; //this will help chatScreen for data available or not
      return announcementData;
    } catch (e) {
      print("Error fetching room data: $e");
      return [];
    }
  }

  //-------PIPELINE:1.localDBfetch -->fetchFromApi -->updateLocalDBwithNewData --> UpdateUI ------------------------------------------//
  ///STAGE 1:localDB
  Future<void> fetchAllRoomDataFromLocalDB(AppDb db) async {
    print("..Room pipeline started...");
    try {
      _userProjects = await fetchRoomDataFromLocalDB(db);
      _announcement = await fetchAnnouncementDataFromLocalDB(db);
    } catch (e) {
      // print("Error fetching data from local storage: $e");
    } finally {
      _isRoomLoaded = true;
      notifyListeners();
    }
  }

  ///STAGE2:APIdata
  Future<void> fetchAllRoomDataFromApi(AppDb db) async {
    try {
      List<Rooms>? newAnnouncements = await saveAnnouncementToLocalDb(db);
      List<Rooms>? newProjects = await saveRoomsToLocalDb(db);
      compareAndUpdate(newProjects, newAnnouncements, db);
    } catch (e) {
    } finally {
      // notifyListeners();
    }
  }

  ///STAGE3:syncRoomsDataWithApi

  ///STAGE4:compare and update UI
  void compareAndUpdate(
      List<Rooms>? newProjects, List<Rooms>? newAnnouncements, db) async {
    // print("inside compareAndUpdate");

    try {
      int temp = await db.deleteUnsyncedRooms();
      notifyListeners();
      // await fetchAllRoomDataFromApi(db);
    } catch (e) {
      print("ERROR compareAndUpdate:${e}");
    }
  }

  // ---------------------------------------------------messageDataSavingAndFetching--------------------------------------------------//
  //savingAllStaticMessageFromAPi
  Future<void> workerToSaveMessage(
      MessageModel message, db, String messageRoomId) async {
    // print("Inside workerToSaveMessage");

    // Use a transaction and batch to ensure atomicity and improve performance
    try {
      await db.transaction(() async {
        // Saving poll data and poll option data inside a batch
        if (message.poll != null) {
          final pollCompanion = PollTableCompanion(
            id: drift.Value(message.id!),
            title: drift.Value(message.poll!.title),
            description: drift.Value(message.poll!.description ?? ''),
            lastVoted: drift.Value(message.poll!.lastVoted ?? null),
          );

          // Insert poll data
          await db.into(db.pollTable).insertOnConflictUpdate(pollCompanion);

          // Insert poll options inside a batch
          for (var option in message.poll!.pollOptions) {
            final pollOptionCompanion = PollOptionTableCompanion(
              id: drift.Value(option.id),
              pollId: drift.Value(message.id!),
              value: drift.Value(option.value),
              numVotes: drift.Value(option.numVotes),
            );
            await db
                .into(db.pollOptionTable)
                .insertOnConflictUpdate(pollOptionCompanion);
            // print("Success: PollOptionCompanion saved!!");
          }
        }
        final messageCompanion = MessagesTableCompanion(
          id: message.id != null
              ? drift.Value(message.id!)
              : drift.Value.absent(),
          type: drift.Value(message.type.toString().split('.').last),
          timestamp: drift.Value(message.timestamp!.millisecondsSinceEpoch),
          sentFromName: message.sentFrom?.name != null
              ? drift.Value(message.sentFrom!.name!)
              : drift.Value.absent(),
          replyToId: drift.Value(
              message.replyTo != null ? (message.replyTo as ReplyTo).id : null),
          isSynced: drift.Value(true),
          textData: message.type == MessageType.text && message.text != null
              ? drift.Value(message.text)
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

  Future<List<MessageModel>?> saveStaticMessageToLocalDb(
      AppDb db, String roomID) async {
    try {
      List<MessageModel>? allMessages = roomID != null
          ? await chatP.getChatMessages(
              tempRoomId: roomID, uid: userProv.getUserInfo.uid!)
          : [];
      if (allMessages!.isEmpty) {
        return [];
      }
      for (MessageModel message in allMessages) {
        await workerToSaveMessage(message, db, roomID);
      }
      return allMessages;
    } catch (e) {
      print('Error saving message to local DB: $e');
      return null;
    }
  }

  //--------------------------------------------------fetchAllMessageOfRoomFromLocalDB-----------------------------------------------//
  Future<List<MessageModel>> fetchAllMessagesFromLocalDB(
      AppDb db, String roomID) async {
    print(
        "----inside the fetching all message from local database and roomId is $roomID");
    try {
      // Perform a join query to fetch messages along with sender details
      final query = db.select(db.messagesTable).join([
        leftOuterJoin(
          db.roomMemberTable,
          db.messagesTable.sentFromName.equalsExp(db.roomMemberTable.name),
        ),
      ])
        ..where(db.messagesTable.roomId.equals(int.parse(roomID)));
      final results = await query.get();
      List<MessageModel> messages = [];
      for (final row in results) {
        final message = row.readTable(db.messagesTable);
        final user = row.readTableOrNull(db.roomMemberTable);

        final pollQuery = db.select(db.pollTable)
          ..where((tbl) => tbl.id.equals(message.id));
        final pollQueryData = await pollQuery.getSingleOrNull();
        final pollOptionQuery = db.select(db.pollOptionTable)
          ..where((tbl) => tbl.pollId.equals(message.id));
        final pollOptionQueryData = await pollOptionQuery.get();

        PollData? pollData;
        List<PollOption> pollOptionData = [];
        try {
          if (pollOptionQueryData != null) {
            // If poll exists, collect all associated poll options
            for (final pollOptionRow in pollOptionQueryData) {
              if (pollOptionRow != null && pollOptionRow.id != null) {
                pollOptionData.add(PollOption(
                    id: pollOptionRow.id!,
                    value: pollOptionRow.value,
                    numVotes: pollOptionRow.numVotes));
              }
            }
            if (pollQueryData != null) {
              pollData = PollData(
                title: pollQueryData!.title,
                description: pollQueryData.description!,
                pollOptions: pollOptionData,
                lastVoted: pollQueryData.lastVoted,
              );
            } else {
              pollData = null;
            }
          }
        } catch (e) {
          print("error in pollOption fetching:$e");
        }
        try {
          ReplyTo? replyTo;
          if (message.replyToId != null) {
            // Fetch the referenced message for replyTo
            final replyMessage = await (db.select(db.messagesTable)
                  ..where((tbl) => tbl.id.equals(message.replyToId!)))
                .getSingleOrNull();
            final roomDetails = await (db.select(db.roomsTable)
                  ..where((tbl) => tbl.id.equals(message.roomId!)))
                .getSingleOrNull();
            if (replyMessage != null && roomDetails != null) {
              replyTo = ReplyTo(
                id: replyMessage.id,
                type: MessageType.values.byName(replyMessage.type ?? 'text'),

                timestamp: DateTime.fromMillisecondsSinceEpoch(
                    replyMessage.timestamp!),
                sentFrom: user != null
                    ? SentFrom(
                        id: user.id,
                        name: user.name,
                        email: user.email,
                        type: user.role,
                        registered: user.registered,
                        dp: user.dpUrl,
                        emailVerified: user.emailVerified,
                      )
                    : null,
                roomId: RoomId(
                    id: roomDetails!.id,
                    description: roomDetails!.description,
                    dpUrl: roomDetails!.dpUrl,
                    name: roomDetails!.name,
                    timestamp: roomDetails!.timestamp,
                    type: roomDetails!.type),
                replyTo: null, // Root of reply chain
              );
            }
          }
        } catch (e) {
          print("Error fetching replyTo:$e");
        }

        // Add the constructed MessageModel to the list
        try {
          messages.add(MessageModel(
              id: message.id,
              text: message.textData,
              type: MessageType.values.byName(message.type!),
              timestamp:
                  DateTime.fromMillisecondsSinceEpoch(message.timestamp!),
              sentFrom: user != null
                  ? SentFrom(
                      id: user.id,
                      name: user.name,
                      email: user.email,
                      type: user.role,
                      registered: user.registered,
                      dp: user.dpUrl,
                      emailVerified: user.emailVerified,
                    )
                  : null,
              replyTo: replyTo != null ? replyTo! : null,
              poll: pollData));
        } catch (e) {
          print("problem in this :$e");
        }
      }

      return messages;
    } catch (e) {
      print('Error fetching messages from local DB: $e');
      return [];
    } finally {
      notifyListeners();
    }
  }

  ///-----------------PIPELINE:FOR MESSAGE--------------------///
  ///Step1:fetching from localDB and displaying on UI
  ///Step2:fetching from Api and update localDB.
  Future<void> staticMessagePipeline(AppDb db, String roomID) async {
    print("..Message pipeline started...");
    try {
      messages = await fetchAllMessagesFromLocalDB(db, roomID);
      // print("\n\ncheck:${_messages}\n\n");
      print("stage1 done:MessagePipeline");
      _messageStreamController.add(messages);
    } catch (e) {
      print("Error in stage1:messagePIPELINE: $e");
      _messageStreamController.addError("Error to load message from localDB");
    } finally {
      messages = List.from(messages!);
      notifyListeners();
    }
    // List<MessageModel>?_newMessage;
    try {
      await saveStaticMessageToLocalDb(db, roomID);
      final newMessages = await fetchAllMessagesFromLocalDB(db, roomID);

      ///FIX:multiple time fetching
      if (newMessages != null) {
        // Check and add only unique messages
        final existingIds = messages?.map((msg) => msg.id).toSet() ??
            {}; // Get IDs of existing messages
        for (var newMessage in newMessages) {
          if (!existingIds.contains(newMessage.id)) {
            messages?.add(newMessage);
          }
        }
      }

      print("stage2 done:MessagePipeline");
    } catch (e) {
      print("error in stage2:messagePIPLINE:$e");
    } finally {
      _messageStreamController.add(messages);
      notifyListeners();
    }
  }

  ///Step3:dynamic message update 1.to local db 2.to UI (handle by websocket)

  //----------------------------------------------------------POLLS----------------------------------------------------//
  int length = 0;

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
      // print('Invalid URL: $imageUrl');
      return "";
    }
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
    } catch (e) {
      print("\nError during saving image to path: $e");
      return ""; // Return an empty string on failure
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

  Widget customUserName(String name, {double radius = 50.0}) {
    // print("inside teh customUserName");
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
    _messageStreamController.add(messages);

    final messageData = {
      "chatId": messageId,
      "voterId": userProv.getUserInfo.id!,
      "optionId": optionId,
    };
    int pollIndex = messages.indexWhere(
      (element) => element.id! == messageId,
    );
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
      "roomId": int.parse(_roomId),
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

  String get fileUri => _fileUri;
  String get fileName => _fileName;

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
      "roomId": int.parse(_roomId),
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
  }

  //=====================================================older code===================================================================//

  void addRouteListener(
      BuildContext context, var room, var user, UserProv userProv) {
    ModalRoute.of(context)?.addScopedWillPopCallback(() {
      // roomLeft(room, user, userProv);
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
    _messageStreamController.close();
    super.dispose();
  }
}
