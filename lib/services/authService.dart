import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<String> _getVerificationToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('verification_token');
  }

  Future<bool> _deleteVerificationToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('verification_token');
  }

  Future<bool> _setVerificationCode(token) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.setString('verification_token', token);
  }

  Future<bool> login(String token) async {
    if (token == null) {
      token = await _getVerificationToken();
    }

    if (token == null) {
      return await Future<bool>.delayed(Duration(seconds: 2), () => false);
    }

    return await Future<bool>.delayed(
        Duration(seconds: 2), () async => await _setVerificationCode(token));
  }

  Future<bool> logout() async {
    return await _deleteVerificationToken();
  }
}
