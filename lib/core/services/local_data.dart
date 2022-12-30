import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  static LocalData? _instance;
  late SharedPreferences prefs;
  LocalData._();
  static LocalData get getInstance => (_instance ??= LocalData._());

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    if (token == null) {}
    return;
  }

  Future setToken(String? token) async {
    if (token == null) {
      await prefs.remove('token');
    } else {
      await prefs.setString('token', token);
    }
  }

  String? get token {
    return prefs.getString('token');
  }
}
