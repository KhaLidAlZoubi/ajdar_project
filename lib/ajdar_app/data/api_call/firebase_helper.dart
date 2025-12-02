// import 'package:firebase_messaging/firebase_messaging.dart';

// import '../../../conest.dart';

// class FirebaseHelper {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   Future<void> initNotification() async {
//     await _firebaseMessaging.requestPermission();
//     final fcmToken = await _firebaseMessaging.getToken();
//     print('FCM TOKEN: $fcmToken');
//     box.write('fcm', fcmToken);
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   }
// }

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   print("Message title: ${message.notification?.title}");
//   print("Message title: ${message.notification?.body}");
// }
