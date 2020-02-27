import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationManager {
  FirebaseNotificationManager._();
  factory FirebaseNotificationManager() => _instance;
  static final FirebaseNotificationManager _instance =
      FirebaseNotificationManager._();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  String token;
  bool _initialized = false;
  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      if (Platform.isIOS) _iOSPermission();

      firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
        print("onmessge: $message");
      }, onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      }, onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      });

      // For testing purposes print the Firebase Messaging token
      token = await firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;      
    }    
  }

  Future<String> getToken() async {
    if(_initialized){
      return token;
    }
    else {
      await init();
      return token;
    }
  }

  void _iOSPermission() {
    firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
