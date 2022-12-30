import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveToken(String token) {
    prefs.setString("token", token);
  }

  static void clearData() {
    prefs.clear();
  }

  static String? getToken() {
    return prefs.getString("token");
  }

  static bool isLoggedIn() {
    var token = prefs.get("token");
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  static void removeToken() async {
    prefs.remove("token");
  }
}
