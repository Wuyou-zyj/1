import 'package:shared_preferences/shared_preferences.dart';
class User{
  User._();
  static const String url = '';
  static String _sid = '';
  static String _uid = '';
  static String _pas = '';
  static String _token = '';

  static String get sid => _sid;
  static String get uid => _uid;
  static String get pas => _pas;
  static String get token => _token;

  static Future<void> setInf(String sidd, String uidd, String pass, String tokenn)async{
    final prefs = await SharedPreferences.getInstance();
    _sid = sidd;
    _uid = uidd;
    _pas = pass;
    _token = tokenn;
    prefs.setString("sid_f", sidd);
    prefs.setString("uid_f", uidd);
    // prefs.setString("pas_f", pass);
    prefs.setString("token_f", tokenn);
  }

  static Future<void> init()async{
    final prefs = await SharedPreferences.getInstance();
    _sid = prefs.getString('sid_f')??_sid;
    _uid = prefs.getString('uid_f')??_uid;
    // _pas = prefs.getString('pas_f')??_pas;
    _token = prefs.getString('token_f')??_token;
  }

  static Future<void> setToken(String token)async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token_f", token);
  }
}