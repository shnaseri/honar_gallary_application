import 'package:honar_api_v8/api.dart';
import 'package:honar_gallary/logic/shared_per.dart';

class ConfigGeneralValues {
  late SharedPreferencesHandler sharedPreferencesHandler;
  static ConfigGeneralValues? configGeneralValues;
  late List<Category> categories;

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

  void setListCategory(List<Category> categoryGetAllList) {
    categories = [Category(name: "همه", id: -1), ...categoryGetAllList];
  }

  List<Category> getCategories() {
    return categories;
  }
}
