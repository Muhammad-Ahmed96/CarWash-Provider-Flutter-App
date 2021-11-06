import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // checking authToken
  static Future<int> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int token = prefs.getInt("token") as int;
    return token;
  }

// set AuthToken once user login completed
  static Future<bool> setToken(int token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("token", token);
    return true;
  }
}
