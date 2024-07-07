import 'package:go_router/go_router.dart';

import '../views/pages/home/home_page.dart';
import '../views/pages/login/login_page.dart';
import '../views/pages/setting/setting_page.dart';
import '../views/widgets/layout.dart';

// ルーティングの定数
// 動的な path などをどう表現するか
class Routes {
  static const String homeRoute = '/home';

  static const String loginRoute = '/login';
  static const String settingRoute = '/setting';
}

// パスの定数
// ネストされたルーティングの場合に使う
// Routes は / を含むが、ネストされた GoRoute の path は / を含められないので、こちらを使う
class Paths {
  static const String login = 'login';
}

// ユニークな名前
// goNamed で遷移する際に使う
class RouteNames {
  static const String homeLoginName = 'home_login';
}

final GoRouter router = GoRouter(
  initialLocation: '/home',
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Layout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: Routes.homeRoute,
                builder: (context, state) => HomePage(),
                routes: [
                  GoRoute(
                    path: Paths.login,
                    name: RouteNames.homeLoginName,
                    builder: (context, state) => LoginPage(),
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.loginRoute,
              builder: (context, state) => LoginPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingRoute,
              builder: (context, state) => SettingPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
