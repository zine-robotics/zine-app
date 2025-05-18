import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:zineapp2023/utilities/custom_logger.dart';
import 'firebase_options.dart';

final logger = customLogger();

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    criticalAlert: true,
  );
  await messaging.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.d('Handling a background message: ${message.messageId}');
}
