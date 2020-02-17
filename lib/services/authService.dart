import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final _apiBase = 'https://eniac-eniactest.azurewebsites.net/api/v1';

  Future<String> getVerificationTokenLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('verification_token');
  }

  Future<String> _getVerificationTokenServer(String verifyCode) async {
    final url = '$_apiBase/Verify?verifyCode=$verifyCode';
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

  Future<bool> _deleteVerificationToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('verification_token');
  }

  Future<bool> _setVerificationCode(token) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.setString('verification_token', token);
  }

  Future<bool> _authorizeToken(String verifyToken) async {
    final url = '$_apiBase/Authorize?authGid=$verifyToken';
    print('authorize url: $url');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Cannot authorize verification token');
    }
  }

  Future<bool> login(String verifyCode) async {
    String token;
    if (verifyCode == null) {
      token = await getVerificationTokenLocal();
    }

    if (token != null) {
      try {
        return await _authorizeToken(token);
      } catch (e) {
        print('authorize error: $e');
        return await Future<bool>.delayed(Duration(seconds: 2), () => false);
      }
      //return await Future<bool>.delayed(Duration(seconds: 2), () => true);
    }

    if (verifyCode == null) {
      return false;
    }

    try {
      token = await _getVerificationTokenServer(verifyCode);
      print('verification token: $token');
      return await _setVerificationCode(token);
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
