import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineapp2023/common/navigator.dart';
import 'package:zineapp2023/screens/chat/chat_screen/view_model/chat_room_view_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

//------------------------------local notification plugin setup-----------------------------------//
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
//--------------------------------backend Message Listener----------------------------------------//
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

//--------------------------------show foreground notification------------------------------------//
Future<void> _showNotification({String? title, String? body}) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your_channel_id', 'your_channel_name',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          icon: '@drawable/zine_logo1');
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}

//-------------------------------------listen notification by FCM--------------------------//
void setupForegroundMessageListener() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print("message data:${message.data}  message notification data:${message.notification?.body}");
    if (message.notification != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedRoomName = prefs.getString("roomName");

      if (storedRoomName != message.notification?.title) {
        await _showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
        );
      }
      print("object");
      print(NavigationService.navigatorKey.currentContext!);
      // Provider.of<ChatRoomViewModel>(
      //   NavigationService.navigatorKey.currentContext!,
      //   listen: false,
      // ).loadRooms();
    }
  });
}
