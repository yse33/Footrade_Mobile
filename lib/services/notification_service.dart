import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
  }

  static Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
    print('Handling a background message ${message.messageId}');
  }

  Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }
}