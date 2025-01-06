import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zineapp2023/background/notification_handle.dart';
import './screens/onboarding/splash/splash.dart';
import './app_providers.dart';
import './common/data_store.dart';
import './providers/dictionary.dart';
import './providers/user_info.dart';
import './common/navigator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'background/firebase_options.dart';
import 'database/database.dart';

final Language _language = Language();

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  // print("Handling a background message: ${message.notification.}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _language.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Message Notification',
      id: 'chats',
      importance: NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats');
  await initializeNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AppDb db=AppDb();
  await db.initializeIsSyncedColumn();
  setupForegroundMessageListener();


  // log('\nNotification Channel Result: $result');
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // ignore: unused_local_variable

  DataStore store = DefaultStore();
  UserProv userProv = UserProv(dataStore: store,Db:db);
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  runApp(MyApp(store: store, userProv: userProv, secureStorage: secureStorage ,db:db));
}

class MyApp extends StatelessWidget {
  final DataStore store;
  final UserProv userProv;
  final FlutterSecureStorage secureStorage;
  final AppDb db;

  const MyApp(
      {super.key,
      required this.store,
      required this.userProv,
      required this.secureStorage,
      required this.db});

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      language: _language,
      userProv: userProv,
      store: store,
      db: db,
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Zine',
        theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.blue,
            useMaterial3: false),
        home: const SplashScreen(),
      ),
    );
  }
}
