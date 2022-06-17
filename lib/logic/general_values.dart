import 'package:honar_gallary/logic/shared_per.dart';

class ConfigGeneralValues {
  late SharedPreferencesHandler sharedPreferencesHandler;
  static ConfigGeneralValues? configGeneralValues;
  int? userId;

  static ConfigGeneralValues getInstance() {
    configGeneralValues ??= ConfigGeneralValues();
    return configGeneralValues!;
  }

  ConfigGeneralValues() {
    sharedPreferencesHandler = SharedPreferencesHandler();
  }

  void putToken(String token) {
    sharedPreferencesHandler.saveToken(token);
  }

  void setUserId(int userId) {
    this.userId = userId;
  }
}
