import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<String?> getUserFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  static Future<void> saveUserInLocalStorage(String jwtToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jwtToken);
  }
}