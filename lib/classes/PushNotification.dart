import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  PushNotificationManager._();
  factory PushNotificationManager() => _instance;
  static final PushNotificationManager _instance = PushNotificationManager._();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;
  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async{          
          print("onmessge: $message");
        },
        onLaunch: (Map<String, dynamic> message) async{
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async{
          print("onResume: $message");
        }
      );

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}
