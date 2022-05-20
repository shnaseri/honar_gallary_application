import 'package:nb_utils/nb_utils.dart';

class SharedPreferencesHandler {
  static SharedPreferences? _sharedPreferences;

  SharedPreferencesHandler() {
    initStorage();
  }

  Future<void> initStorage() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  bool saveToken(String token) {
    _sharedPreferences!.setString("Token", token);
    return true;
  }

  String? getToken() {
    return _sharedPreferences!.getString("Token");
  }
}
