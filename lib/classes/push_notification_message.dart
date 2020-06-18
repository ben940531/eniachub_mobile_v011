import 'package:flutter/cupertino.dart';

class PushNotificationMessage {
  final String title;
  final String body;

  const PushNotificationMessage({
    @required this.title,
    @required this.body,
  });
}
