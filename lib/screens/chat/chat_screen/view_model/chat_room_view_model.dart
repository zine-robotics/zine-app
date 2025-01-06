import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
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
    _isNewRoomData=false;
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
  List<MessageModel> _messages = [];
  bool _isLoaded = false; //It should be true at
  bool _isError = false;
  bool _isNewRoomData=false;//track new Room data
  final StreamController<List<MessageModel>> _messageStreamController =
      StreamController<List<MessageModel>>.broadcast();
  List<MessageModel> get messages => _messages;
  Set<String> activeRoomSubscriptions = {};

  bool get isLoaded => _isLoaded;
  bool get isError => _isError;
  bool get isNewRoomData =>_isNewRoomData;
  Stream<List<MessageModel>> get messageStream =>
      _messageStreamController.stream;
  Future<void> fetchMessages(String TemproomId) async {
    try {
      _messages = await chatP.getChatMessages(TemproomId);
      _messageStreamController.add(_messages);
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
    print("\n----------initializing web socket------------\n ");
    _client = StompClient(
      config: StompConfig(
        useSockJS: true,
        url: BackendProperties.websocketUri.toString(),
        onConnect: onConnectCallback,
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
  void subscribeToActiveMember(String currRoomID)
  {
    print("\n \ninside the subscribeToActiveMemeberRoom & roomId:$roomId");
    List<NewUserModel> ActiveMemberData;
    final subscription=_client.subscribe(
        destination: "/room/$currRoomID/active-users",
        // headers: BackendProperties.getHeaders(),
        callback: (StompFrame frame) async{
        try{
          print("inside the activemember try block");
          // final Map<String, dynamic> activeMemberData = json.decode(frame.body!);
          // NewUserModel activeMemberData1=NewUserModel.fromJson(activeMemberData);
          // print("\n newly created websocket acive user data:${activeMemberData1}");
        }
        catch(e)
          {
            print("ERROR:subscribeToActiveMemeber: $e");
          }
        });
  }

  void subscribeToRoom(String roomId,AppDb db) {
    print("inside the subscribeToRoom & roomId:$roomId");
    if (!_client.connected) {
      print("client is not connected");
      return;
    }
    activeRoomSubscriptions.add(roomId);
    final subscription = _client.subscribe(
      destination: '/room/$roomId', //  widget.chatId
      headers: BackendProperties.getHeaders(),
      callback: (StompFrame frame) async {
        // messageData = json.decode(frame.body!);

        // print("frame.body:${frame.body}");
        try {
          final Map<String, dynamic> messageData = json.decode(frame.body!);
          MessageModel messageData1 = MessageModel.fromJson(messageData);
          await workerToSaveMessage(messageData1, db);
          _messages.add(messageData1);
          _messageStreamController.add(List.from(_messages));
          print("success!!");
        } catch (e) {
          print("\n error parsing messaging :${e} \n");
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

  void setRoomId(String roomId,AppDb db) {
    // print("insdie the setRoomID:$roomId");
    if (_roomId != roomId) {
      unsubscribeFromRoom(_roomId);
      _roomId = roomId;
      subscribeToRoom(roomId,db);
      subscribeToActiveMember(roomId);
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
      "content": user_message.toString(),
      "timestamp": DateTime.now()
          .millisecondsSinceEpoch, // or DateTime.now().toIso8601String()
      "sentFrom": userProv.getUserInfo.id!,
      "roomId": int.parse(_roomId),
    };
    if (replyTo != null && replyUsername != null) {
      messageData['replyTo'] = replyTo;
    }
    // print("during sent replyTo:$replyTo \t replyusername:$replyUsername");
    final jsonBody = json.encode(messageData);

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
        // print("announcement:${_announcement}");
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
  dynamic updateSeen(String email_id, String room_id, int userLastSeen,
      int lastMessageTimestamp, int unreadMessages) async {
    Uri url = BackendProperties.updateLastSeenUri(email_id, room_id);
    String uid = userProv.getUserInfo.uid!;
    // print("inside teh updateSeen for email:$email_id and roomid:$room_id");
    try {
      final Map<String, dynamic> jsonData = {
        'info': {
          'userLastSeen': userLastSeen,
          'lastMessageTimestamp': lastMessageTimestamp,
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
  List<ActiveMember> _activeMembers = [];
  List<ActiveMember> get activeMembers => _activeMembers;
  dynamic getTotalActiveMember(AppDb db,String roomId) async {
    // print("inside the totalactivemember");
    // _activeMembers = await chatP.fetchTotalActiveMember(roomId);
    // notifyListeners();
    try{
      final query = db.select(db.usersTable,distinct: true,).join([
        innerJoin(
          db.messagesTable,
          db.messagesTable.sentFromId.equalsExp(db.usersTable.id),
        ),
      ])
        ..where(db.messagesTable.roomId.equals(int.parse(roomId)))
        ..groupBy([db.usersTable.id]);

      // Mapping the result to a list of UserDB objects
      final results = await query.get();

      List<ActiveMember> activeUserDetails = results.map((row) {
        final userRow = row.readTable(db.usersTable); // Read the user table data

        return ActiveMember(
          name: userRow.name,
          email: userRow.email,
          role: userRow.type,
          dpUrl: userRow.dp,
        );
      }).toList();
      _activeMembers=activeUserDetails;


    }
    catch (e)
    {
      print("ERROR:getTotalActiveMember:${e}");
    }
  }

  //------------------------------------------------------------chat text value-------------------------------------------//
  String _text = "";
  get text => _text;

  void setText(String value) {
    _text = value;
  }
//===============================================================LOCAL STORAGE========================================================//
  //-----------------------------------------------------------save RoomDetails to local DB-------------------------------------------//
  static List<RoomsTableCompanion>? _apiRoomData;
  static List<RoomsTableCompanion>? _apiAnnouncementData;
  List<Room>? _toDeleteRoomData;
  Future<List<Rooms>?> saveRoomsToLocalDb(AppDb db) async {
    UserModel currUser = userProv.getUserInfo;
    String? email = currUser.email;
    try {
      List<Rooms>? allRooms = email!=null? await chatP.fetchRooms(email!):[];
      if (allRooms!.isEmpty) {
        // print('No rooms to save. The list is empty.');
        return []; // Exit the function if no rooms to save
      }
      for (Rooms room in allRooms!) {
        final roomCompanion = RoomsTableCompanion(
          id: room.id != null ? drift.Value(room.id!) : drift.Value.absent(),
          name: drift.Value(room.name),
          description: drift.Value(room.description),
          type: drift.Value(room.type),
          dpUrl: drift.Value(await saveImageToLocalStorage(room.dpUrl.toString(),room.id.toString(),room.name.toString()) ),
          timestamp: drift.Value(room.timestamp),
          lastMessageTimestamp: drift.Value(room.lastMessageTimestamp),
          unreadMessages: drift.Value(room.unreadMessages),
          userLastSeen: drift.Value(room.userLastSeen),
            isSynced: drift.Value(true)
        );
        _apiRoomData?.add(roomCompanion);
        // for inserting RoomData and checking new data.
        final insertedId = await db.insertRoomToDB(roomCompanion);
        if (insertedId == -1) {
          // print('RoomProject Data inserted successfully with ID: $insertedId');
          // _isNewRoomData=true;
        } else {
          // print('RoomProject Data updated: ${room.name}');
        }

      }
      return allRooms;
    } catch (e) {
      print('Error saving rooms to local DB: $e');
    }
  }
  //-----------------------------------------------------fetchRoomDataFromLocalDB------------------------------------------------------//

  Future<List<Rooms>> fetchRoomDataFromLocalDB(db) async {
    // print("Fetching from local Storage");

    try {
      List<Room> temp = await db.getAllProjectsDB();
      List<Rooms> userProjectData;
      userProjectData= temp.map((room) {
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
      // temp.forEach((room) {
      //   print("Room ID: ${room.id}");
      //   print("Room Name: ${room.name}");
      //   print("Room Description: ${room.description}");
      //   print("Room Type: ${room.type}");
      //   print("Room DP URL: ${room.dpUrl}");
      //   print("Timestamp: ${room.timestamp}");
      //   print("Last Message Timestamp: ${room.lastMessageTimestamp}");
      //   print("Unread Messages: ${room.unreadMessages}");
      //   print("User Last Seen: ${room.userLastSeen}");
      //   print("=================================^^====");
      // });

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
      List<Rooms>? allRooms = email!=null? await chatP.fetchAnnouncement(email!):[];
      if (allRooms!.isEmpty) {
        // print('No Announcement to save. The list is empty.');
        return []; // Exit the function if no rooms to save
      }
      for (Rooms room in allRooms!) {
        final roomCompanion = RoomsTableCompanion(
          id: room.id != null ? drift.Value(room.id!) : drift.Value.absent(),
          name: drift.Value(room.name),
          description: drift.Value(room.description),
          type: drift.Value(room.type),
          dpUrl: drift.Value(await saveImageToLocalStorage(room.dpUrl.toString(),room.id.toString(),room.name.toString()) ),
          timestamp: drift.Value(room.timestamp),
          lastMessageTimestamp: drift.Value(room.lastMessageTimestamp),
          unreadMessages: drift.Value(room.unreadMessages),
          userLastSeen: drift.Value(room.userLastSeen),
          isSynced: drift.Value(true)
        );
        _apiAnnouncementData?.add(roomCompanion);
        // inserting annoucement data and check of any updates
        final insertedId = await db.insertRoomToDB(roomCompanion);
        if (insertedId == -1) {
          // print('Announcement Data inserted successfully with ID: $insertedId');
          // _isNewRoomData=true;
        } else {
          // print('updated Announcement Data: ${room.name}');
          // print("_isNewRoomData:$_isNewRoomData");
        }
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

      // Print the mapped Rooms objects for debugging
      temp.forEach((room) {
        print("Room ID: ${room.id}");
        print("Room Name: ${room.name}");
        print("Room Description: ${room.description}");
        print("Room Type: ${room.type}");
        print("Room DP URL: ${room.dpUrl}");
        print("Timestamp: ${room.timestamp}");
        print("Last Message Timestamp: ${room.lastMessageTimestamp}");
        print("Unread Messages: ${room.unreadMessages}");
        print("User Last Seen: ${room.userLastSeen}");
        print("=================================^^====");
      });
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
      _userProjects= await fetchRoomDataFromLocalDB(db);
      _announcement = await fetchAnnouncementDataFromLocalDB(db);

    } catch (e) {
      // print("Error fetching data from local storage: $e");
    }
    finally
        {
          _isRoomLoaded = true;
        notifyListeners();
        }
  }
  ///STAGE2:APIdata
  Future<void> fetchAllRoomDataFromApi(AppDb db) async {
    try{

      List<Rooms>? newAnnouncements= await saveAnnouncementToLocalDb(db);
      List<Rooms>? newProjects=await  saveRoomsToLocalDb(db);
      // compareAndUpdate(newProjects, newAnnouncements,db);
    }catch(e)
    {

    }
    finally{
        // notifyListeners();
    }
  }
  ///STAGE3:syncRoomsDataWithApi



  ///STAGE4:compare and update UI
  void compareAndUpdate(List<Rooms>? newProjects, List<Rooms>? newAnnouncements,db) async {
    // print("inside compareAndUpdate");

    try {
      int temp = await db.deleteUnsyncedRooms();
      // await fetchAllRoomDataFromApi(db);
    }
    catch(e)
    {
      print("ERROR compareAndUpdate:${e}");
    }
      // print("Value of temp: $temp");
    //   if (temp == -1) {
    //     _isNewRoomData = true;
    //   }
    //   if (_isNewRoomData) {
    //     // _userProjects = newProjects;
    //     // _announcement = newAnnouncements;
    //     await fetchAllRoomDataFromApi(db);
    //
    //     // print("Rooms Data has changed");
    //   } else {
    //     // print("Rooms Data has not changed");
    //   }
    // } catch (e) {
    //   print("Error in compareAndUpdate: $e");
    // }
    // finally
    //     {
    //       // notifyListeners();
    //     }

  }
  // ---------------------------------------------------messageDataSavingAndFetching--------------------------------------------------//
  //savingAllStaticMessageFromAPi
  Future<void> workerToSaveMessage(MessageModel message,db) async
  {
    // print("inside the workerToSaveMessage");
    {
      try{
        if (message.sentFrom?.id != null) {
          final userCompanion = UsersTableCompanion(
            id: drift.Value(message.sentFrom!.id!),
            name: drift.Value(message.sentFrom!.name ?? 'Anonymous'),
            email: drift.Value(message.sentFrom!.email),
            type: drift.Value(message.sentFrom!.type),
            pushToken: drift.Value(message.sentFrom!.pushToken),
            registered: drift.Value(message.sentFrom!.registered ?? false),
            dp: drift.Value(await saveImageToLocalStorage(message.sentFrom!.dp.toString(), message.sentFrom!.id!.toString(),message.sentFrom!.name.toString()) ),//message.sentFrom!.dp ?? ''
            emailVerified: drift.Value(message.sentFrom!.emailVerified),
          );

          // Upsert user (insert or update if exists)
          try {
            await db.into(db.usersTable).insertOnConflictUpdate(userCompanion);
            // print("users details updates for ${userCompanion.name}");
          } catch (e) {
            // print("erorr during insertUpdate users details,${e}");
          }
        }
      }
      catch(e)
    {
      print("ERROR:worker is not doing its job:$e");
    }
    }

    // Insert message data
    final messageCompanion = MessagesTableCompanion(
      id: message.id != null ? drift.Value(message.id!) : drift.Value.absent(),
      content: drift.Value(message.content),
      type: drift.Value(message.type),
      contentUrl: drift.Value(message.contentUrl),
      timestamp: drift.Value(message.timestamp),
      sentFromId: message.sentFrom?.id != null
          ? drift.Value( message.sentFrom!.id!)
          : drift.Value.absent(),
      roomId: drift.Value((message.roomId as RoomId).id),
      replyToId: drift.Value(message.replyTo != null ? (message.replyTo as ReplyTo).id : null),//foregin key :messageID
      isSynced: drift.Value(true),
    );

    await db.into(db.messagesTable).insertOnConflictUpdate(messageCompanion);
    // print("message added:${messageCompanion.content}");
  }
  Future<List<MessageModel>?> saveStaticMessageToLocalDb(AppDb db,String roomID) async {
    try {
      List<MessageModel>? allMessages = roomID != null ? await chatP.getChatMessages(roomID) : [];
      if (allMessages!.isEmpty) {
        // print('No messages to save. The list is empty.');
        return [];
      }

      for (MessageModel message in allMessages) {
        // Insert or update user details
        await workerToSaveMessage(message,db);
      }

      return allMessages;
    } catch (e) {
      print('Error saving message to local DB: $e');
      return null;
    }
  }
  //--------------------------------------------------fetchAllMessageOfRoomFromLocalDB-----------------------------------------------//
  Future<List<MessageModel>> fetchAllMessagesFromLocalDB(AppDb db, String roomID) async {
    try {
      // Perform a join query to fetch messages along with sender details
      final query = db.select(db.messagesTable).join([
        leftOuterJoin(
          db.usersTable,
          db.messagesTable.sentFromId.equalsExp(db.usersTable.id),
        ),
      ])..where(db.messagesTable.roomId.equals(int.parse(roomID)));

      final results = await query.get();

      // Fetch messages and construct MessageModel instances
      List<MessageModel> messages = [];
      for (final row in results) {
        final message = row.readTable(db.messagesTable);
        final user = row.readTableOrNull(db.usersTable);

        // Handle replyTo field
        ReplyTo? replyTo;
        if (message.replyToId != null) {
          // Fetch the referenced message for replyTo
          final replyMessage = await (db.select(db.messagesTable)
            ..where((tbl) => tbl.id.equals(message.replyToId!)))
              .getSingleOrNull();
          final roomDetails=await (db.select(db.roomsTable)..where((tbl)=>tbl.id.equals(message.roomId!))).getSingleOrNull();
          if (replyMessage != null) {
            replyTo = ReplyTo(
              id: replyMessage.id,
              type: replyMessage.type,
              content: replyMessage.content,
              contentUrl: replyMessage.contentUrl,
              timestamp: replyMessage.timestamp,
              sentFrom: user != null
                  ? SentFrom(
                id: user.id,
                name: user.name,
                email: user.email,
                type: user.type,
                pushToken: user.pushToken,
                registered: user.registered,
                dp: user.dp,
                emailVerified: user.emailVerified,
              )
                  : null,
              roomId: roomDetails!=null? RoomId(id: roomDetails!.id,description: roomDetails!.description,dpUrl:roomDetails!.dpUrl ,name:roomDetails!.name ,timestamp:roomDetails!.timestamp ,type: roomDetails!.type):null ,
              replyTo: null, // Root of reply chain
            );
          }
        }

        // Add the constructed MessageModel to the list
        messages.add(MessageModel(
          id: message.id,
          content: message.content,
          type: message.type,
          contentUrl: message.contentUrl,
          timestamp: message.timestamp,
          sentFrom: user != null
              ? SentFrom(
            id: user.id,
            name: user.name,
            email: user.email,
            type: user.type,
            pushToken: user.pushToken,
            registered: user.registered,
            dp: user.dp,
            emailVerified: user.emailVerified,
          )
              : null,
          roomId: message.roomId,
          replyTo: replyTo,
        ));
      }

      return messages;
    } catch (e) {
      print('Error fetching messages from local DB: $e');
      return [];
    }
  }

  ///-----------------PIPELINE:FOR MESSAGE--------------------///
  ///Step1:fetching from localDB and displaying on UI
  ///Step2:fetching from Api and update localDB.
  Future<void> staticMessagePipeline(AppDb db,String roomID) async {
    print("..Message pipeline started...");
    try {
      _messages= await fetchAllMessagesFromLocalDB(db,roomID);
      // print("\n\ncheck:${_messages}\n\n");
      print("stage1 done:MessagePipeline");
      _messageStreamController.add(_messages);
    } catch (e) {
      print("Error in stage1:messagePIPELINE: $e");
      _messageStreamController.addError("Error to load message from localDB");
    }
    finally{
      _messages = List.from(_messages!);
      notifyListeners();
    }
    // List<MessageModel>?_newMessage;
    try{
       await saveStaticMessageToLocalDb(db, roomID);
      final newMessages = await fetchAllMessagesFromLocalDB(db,roomID);///FIX:multiple time fetching
      if (newMessages != null) {
        // Check and add only unique messages
        final existingIds = _messages?.map((msg) => msg.id).toSet() ?? {}; // Get IDs of existing messages
        for (var newMessage in newMessages) {
          if (!existingIds.contains(newMessage.id)) {
            _messages?.add(newMessage); // Add only if the message is not already present
            // print("_messages updated with :${newMessage.content}");
          }
        }

        // print("Added new unique messages to _messages");
      }

      print("stage2 done:MessagePipeline");
    }
    catch(e)
    {
      print("error in stage2:messagePIPLINE:$e");
    }
    finally{
      _messageStreamController.add(_messages);
      notifyListeners();
    }

  }

  ///Step3:dynamic message update 1.to local db 2.to UI (handle by websocket)


  //----------------------------------------------------save the image url as image path-----------------------------------------------//
  Future<String> saveImageToLocalStorage(String imageUrl, String userId, String fileName) async {
    try {
      if (imageUrl.isEmpty || !Uri.parse(imageUrl).isAbsolute) {
        throw Exception('Invalid URL: $imageUrl');
      }

      final sanitizedUrl = Uri.encodeFull(imageUrl.trim());
      // print("\nFetching image from sanitized URL: $sanitizedUrl");

      // Fetch image bytes from URL
      final response = await http.get(Uri.parse(sanitizedUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to load image from URL');
      }
      final imageBytes = response.bodyBytes;

      // Get app directory
      final directory = await getApplicationDocumentsDirectory();

      // Construct directory path and create directories if they don't exist
      final userDirectoryPath = '${directory.path}/$fileName/$userId';
      final userDirectory = Directory(userDirectoryPath);
      if (!await userDirectory.exists()) {
        await userDirectory.create(recursive: true); // Ensure parent directories are created
      }

      // Save image file
      final filePath = '${userDirectory.path}/dp.png';
      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      // print("\nFile path created successfully: $filePath");

      return filePath;
    } catch (e) {
      print("\nError during saving image to path: $e");
      return ""; // Return an empty string on failure
    }
  }

  Widget showProfileImage(String imagePath,{double width=50.0 ,height=50.0,radius=10.0}) {
    // print("\n inside showProfileImage , imagePath:${imagePath}");
    try{
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover, // Ensures the image covers the circle
            width: width, // Set to 2 * radius
            height: height, // Set to 2 * radius

          ),

        );

    }
    catch (e)
    {
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

  Widget customUserName(String name,{double radius=50.0}) {
    print("inside teh customUserName");
    return
       ClipRRect(
        borderRadius: BorderRadius.circular(radius), // Background color of the avatar
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



  //=====================================================older code===================================================================//

      void addRouteListener(BuildContext context, var room, var user,
          UserProv userProv) {
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
