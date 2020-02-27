import 'dart:convert';

import 'package:eniachub_mobile_v011/classes/firebase_notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //base api url for this service
  final _apiBase = 'https://eniac-eniactest.azurewebsites.net/api/v1';

  // get stored mobile device auth Guid with usage of shared_preferences plugin
  Future<String> getVerificationTokenLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('verification_token');
  }

  // send verification code and firebasemessaging token to eniacHUB and get back the device auth Guid
  Future<String> _getVerificationTokenServer(
      String verifyCode, String fireBaseToken) async {
    final url =
        '$_apiBase/Verify?verifyCode=$verifyCode&fireBaseToken=$fireBaseToken';
    print("verification url: $url");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      print("verify response body: $body");
      return body["gId"];
    } else {
      throw Exception('Cannot get verification token');
    }
  }

  // delete mobile device auth Guid from shared_preferences
  Future<bool> _deleteVerificationToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('verification_token');
  }

  // store mobile device auth Guid with shared_preferences plugin
  Future<bool> _setVerificationCode(token) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.setString('verification_token', token);
  }

  // send mobile device auth Guid to eniacHUB, eniacHUB will allow/deny access to mobile application
  Future<bool> _authorizeToken(String authgid) async {
    final url = '$_apiBase/Authorize?authGid=$authgid';
    print('authorize url: $url');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Cannot authorize verification token');
    }
  }

  // main logic for application login
  Future<bool> login(String verifyCode) async {
    String authgid;
    if (verifyCode == null) {
      //try to get device auth Guid locally
      authgid = await getVerificationTokenLocal();
    }

    if (authgid != null) {
      try {
        return await _authorizeToken(authgid);
      } catch (e) {
        print('authorize error: $e');
        return await Future<bool>.delayed(Duration(seconds: 2), () => false);
      }
      //return await Future<bool>.delayed(Duration(seconds: 2), () => true);
    }

    if (verifyCode == null) {
      return false;
    }

    // get token for firebase push notification and send it to eniacHUB
    String firebaseToken = await FirebaseNotificationManager().getToken();

    try {
      authgid = await _getVerificationTokenServer(verifyCode, firebaseToken);
      print('verification token: $authgid');
      return await _setVerificationCode(authgid);
    } catch (e) {
      print('print error: $e');
      return await Future<bool>.delayed(Duration(seconds: 2), () => false);
    }

    // return await Future<bool>.delayed(
    //     Duration(seconds: 2), () async => await _setVerificationCode(token));
  }

  Future<bool> logout() async {
    return await _deleteVerificationToken();
  }
}
