import 'package:shared_preferences/shared_preferences.dart';

class Consts{
  static const String isLogin = 'is_login';
  static const String isSkipped = 'is_skipped';
  static const String token = 'token';
}

class Pref {
  static late SharedPreferences instance;
}
