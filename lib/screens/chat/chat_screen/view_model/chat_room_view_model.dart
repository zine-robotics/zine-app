import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:zineapp2023/models/message.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/backend_properties.dart';

import '../../../../models/events.dart';
import '../../../../models/rooms.dart';
import '../repo/chat_repo.dart';
import 'package:http/http.dart' as http;

class ChatRoomViewModel extends ChangeNotifier {
  final UserProv userProv;

  ChatRoomViewModel({required this.userProv}) {
    initializeWebSocket(); //constructor to initialize the webSocket for single time only!!
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
  List<MessageModel> _tempMessages = [];
  bool _isLoading = false;
  bool _isError = false;
  final StreamController<List<MessageModel>> _messageStreamController =
      StreamController<List<MessageModel>>.broadcast();
  List<MessageModel> get messages => _messages;
  Set<String> activeRoomSubscriptions = {};

  bool get isLoading => _isLoading;
  bool get isError => _isError;
  Stream<List<MessageModel>> get messageStream =>
      _messageStreamController.stream;
  Future<void> fetchMessages(String TemproomId) async {
    _isLoading = true;
    // notifyListeners();

    try {
      _messages = await chatP.getChatMessages(TemproomId);
      // _error =null;
      _messageStreamController.add(_messages);
    } catch (e) {
      print(e);
      _messageStreamController.addError('Failed to load data');
      _isError = true;
      // _error ='Failed to load data';
    } finally {
      _isLoading = false;
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

  void subscribeToRoom(String roomId) {
    print("inside the subscribeToRoom & roomId:$roomId");
    if (!_client.connected) {
      print("client is not connected");
      return;
    }
    activeRoomSubscriptions.add(roomId);
    final subscription = _client.subscribe(
      destination: '/room/$roomId', //  widget.chatId
      headers: {},
      callback: (StompFrame frame) {
        // messageData = json.decode(frame.body!);

        // print("frame.body:${frame.body}");
        try {
          final Map<String, dynamic> messageData = json.decode(frame.body!);
          MessageModel messageData1 = MessageModel.fromJson(messageData);

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

  void setRoomId(String roomId) {
    print("insdie the setRoomID:$roomId");
    if (_roomId != roomId) {
      unsubscribeFromRoom(_roomId);
      _roomId = roomId;
      subscribeToRoom(roomId);
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
    print("during sent replyTo:$replyTo \t replyusername:$replyUsername");
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
  bool _isRoomLoading = false;

  List<Rooms>? get userProjects => _userProjects;
  List<Rooms>? get userWorkshop => _userWorkshop;
  List<Rooms>? get announcement => _announcement;
  bool get isRoomLoading => _isRoomLoading;
  int _allChatRoom = 0;
  get allChatRoom => _allChatRoom;
  var fMessaging = FirebaseMessaging.instance;

  Future<void> loadRooms() async {
    UserModel currUser = userProv.getUserInfo;
    String email = currUser.email
        .toString(); //currUser.email.toString();  //FIXME : Fix this

    _isRoomLoading = true;

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

      // _error =null;
    } catch (e) {
      print("load_room:$e");
      // _error ='Failed to load data';
    } finally {
      _isRoomLoading = false;
      notifyListeners();
    }
  }

  void userReplyText(MessageModel message) {
    print("inside the userReplyText");
    print(message);

    selectedReplyMessage = message;
    replyTo = message.id;
    replyUsername = message.sentFrom!.name.toString();
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
  dynamic updateSeen(String email_id, String room_id, int userLastSeen,
      int lastMessageTimestamp, int unreadMessages) async {
    Uri url = BackendProperties.updateLastSeenUri(email_id, room_id);
    String uid = userProv.getUserInfo.uid!;
    print("inside teh updateSeen for email:$email_id and roomid:$room_id");
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
        },
        body: jsonEncode(jsonData),
      );
      if (response.statusCode == 200) {
        print("seen for room:$room_id updated");
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
    print("inside the getlastseen for roomid:$roomId");
    _lastSeen = await chatP.fetchLastSeen(emailId, roomId);
    notifyListeners();
  }

//------------------------------------------------------INFO about Active member-----------------------------//
  List<ActiveMember> _activeMembers = [];
  List<ActiveMember> get activeMembers => _activeMembers;
  dynamic getTotalActiveMember(String roomId) async {
    print("inside the totalactivemember");
    _activeMembers = await chatP.fetchTotalActiveMember(roomId);
    notifyListeners();
  }

  //------------------------------------------------------------chat text value-------------------------------------------//
  String _text = "";
  get text => _text;

  void setText(String value) {
    _text = value;
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
