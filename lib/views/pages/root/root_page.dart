import 'package:flutter/material.dart';

import '../../../routes/generator.dart';
import '../../../routes/navigator_key.dart';
import '../../../services/analytics/events.dart';
import '../../../services/environment/environment.dart';
import '../../../services/rate_my_app/rate_my_app.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key}) {
    AnalyticsEventService().logPage(ScreenName.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 88, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Root Page',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            const SizedBox(height: 16),
            const Text('遷移先'),
            TextButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed(Routes.loginRoute);
              },
              child: const Text('Go to Login Page'),
            ),
            TextButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed(Routes.settingRoute);
              },
              child: const Text('Go to Setting Page'),
            ),
            Text('環境変数テスト: ${Environment().testEnvText}'),
            const SizedBox(height: 16),
            const Text('レビュー催促'),
            TextButton(
              onPressed: () {
                showRateDialog(context);
              },
              child: const Text('Show Review Dialog'),
            )
          ],
        ),
      ),
    );
  }
}
