import 'package:firebase_analytics/firebase_analytics.dart';

enum ScreenName {
  login,
  home,
  setting,
  contactForm,
}

enum TapTarget {
  login,
  logout,
  termsOfService,
}

class AnalyticsEventService {
  // ページ表示イベント
  Future<void> logPage(ScreenName screenName) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'page_view',
      parameters: {
        'screen_name': screenName.name,
      },
    );
  }

  // なにかをタップした際のイベント
  Future<void> logTapEvent(TapTarget tapTarget, ScreenName screenName) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'tap',
      parameters: {'screen_name': screenName.name, 'object': tapTarget.name},
    );
  }
}
