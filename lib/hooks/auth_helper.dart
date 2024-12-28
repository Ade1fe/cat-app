import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static Future<bool> validateLogin(
      String fullName, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedFullName = prefs.getString('fullName');
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    return fullName == savedFullName &&
        email == savedEmail &&
        password == savedPassword;
  }
}
