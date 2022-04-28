import 'package:flutter/material.dart';
import 'package:honar_gallary/UI/Edit_Create_art_piece/edit_art_piece_page.dart';
import 'package:honar_gallary/logic/router_const.dart';

import '../UI/main/main_page.dart';
import '../UI/spash_page.dart';

// import 'package:saffrun_app/UI/splash/splash_page.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashPage());
      case authPagePath:
        return MaterialPageRoute(
            builder: (context) => const AuthenticationPage());
      case homePagePath:
        return MaterialPageRoute(builder: (context) => const MainPage());
      default:
        return null;
    }
  }
}
