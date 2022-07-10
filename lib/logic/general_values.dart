import 'package:honar_api_v19/api.dart';
import 'package:honar_gallary/logic/shared_per.dart';

class ConfigGeneralValues {
  late SharedPreferencesHandler sharedPreferencesHandler;
  static ConfigGeneralValues? _configGeneralValues;
  late List<Category> _categories;

  int? userId;

  late FullUser _profile;

  bool enableBusiness = false;

  List<Category> get categories => _categories;


  static ConfigGeneralValues getInstance() {
    _configGeneralValues ??= ConfigGeneralValues();
    return _configGeneralValues!;
  }

  ConfigGeneralValues() {
    sharedPreferencesHandler = SharedPreferencesHandler();
  }

  void putToken(String token) {
    sharedPreferencesHandler.saveToken(token);
  }

  void setListCategory(List<Category> categoryGetAllList) {
    _categories = [Category(name: "همه", id: -1), ...categoryGetAllList];
  }

  List<Category> getCategories() {
    return _categories;
  }

  void setUserId(int userId) {
    this.userId = userId;
  }

  void setProfile(FullUser fullUser) {
    _profile = fullUser;
  }

  FullUser get profile => _profile;
}
