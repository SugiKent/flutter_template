import 'package:flutter/material.dart';

import '../views/pages/login/login_page.dart';
import '../views/pages/home/home_page.dart';
import '../views/pages/setting/setting_page.dart';

// ルーティングの定数
// 動的な path などをどう表現するか
class Routes {
  static const String rootRoute = '/';
  static const String loginRoute = '/login';
  static const String settingRoute = '/setting';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.rootRoute:
      return MaterialPageRoute(
        builder: (_) => HomePage(),
      );
    case Routes.loginRoute:
      return MaterialPageRoute(
        builder: (_) => LoginPage(),
      );
    case Routes.settingRoute:
      return MaterialPageRoute(
        builder: (_) => SettingPage(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('No route defined')),
              ));
  }
}
