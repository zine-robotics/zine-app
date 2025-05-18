import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:zineapp2023/database/database.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/utilities/custom_logger.dart';
import '../common/data_store.dart';

final logger = customLogger();

class UserProv extends ChangeNotifier {
  final DataStore dataStore;
  AppDb db;
  bool _isLoggedIn = false;
  UserModel _currUser = UserModel();

  UserProv({required this.dataStore, required this.db});

  bool get isLoggedIn => _isLoggedIn;

  FirebaseMessaging fMessaging = FirebaseMessaging.instance;

  Future<String?> getFirebaseMessagingToken() async {
    await fMessaging.requestPermission();

    try {
      var token = await fMessaging.getToken(); // add error handlinig
      logger.d("Firebase $token");

      _currUser.pushToken = token;
      // print('Push Token: $t');
      // updatePushToken();
      // fMessaging.subscribeToTopic("Announcements");
      // for (var rooms in _currUser.rooms!) {
      //   fMessaging.subscribeToTopic(rooms);
      // }
      // }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // print('Got a message whilst in the foreground!');
        // print('Message data: ${message.data}');

        if (message.notification != null) {
          //   print(
          //       'Message also contained a notification: ${message.notification?.title}');
          // }
        }
      });
      return token;
    } on FirebaseException {
      if (kDebugMode) print('Error in getFirebaseMessagingToken');
      return null;
    }
    // }
  }

  Future<void> updatePushToken() async {
    // await _firebaseFirestore
    //     .collection('users')
    //     .doc(_currUser.uid)
    //     .update({'pushToken': _currUser.pushToken});
  }

  void updateUserInfo(UserModel userModel) async {
    _isLoggedIn = true;

    _currUser = userModel;
    logger.i("User Info Loaded ${_currUser.type}");
    await dataStore.setString("loggedIn", 'true');
    await dataStore.setString('id', _currUser.id.toString());
    await dataStore.setString('uid', _currUser.uid.toString());
    await dataStore.setString("email", _currUser.email.toString());
    // await getFirebaseMessagingToken();

    notifyListeners();
  }

  UserModel get getUserInfo => _currUser;

  void updateDpUrl(String url) {
    _currUser.dp = url;
    notifyListeners();
  }

  void updateLast(String name) {
    _currUser.lastSeen[name] = DateTime.now();
  }

  void logOut() async {
    _isLoggedIn = false;
    // _currUser = UserModel();
    // notifyListeners();
    AppDb.deleteUserLocalDb(db);
  }

  // void updateLast(String name) {
  //   _currUser.lastSeen[name] = Timestamp.fromDate(DateTime.now());
  // }
}
