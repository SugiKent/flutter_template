import 'package:flutter/material.dart';

import '../../../routes/generator.dart';
import '../../../routes/navigator_key.dart';
import '../../../services/analytics/events.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key}) {
    AnalyticsEventService().logPage(ScreenName.setting);
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
              'Setting Page',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            TextButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed(Routes.rootRoute);
              },
              child: const Text('Go to Home Page'),
            ),
            TextButton(
              onPressed: () {
                navigatorKey.currentState?.pushNamed(Routes.loginRoute);
              },
              child: const Text('Go to Login Page'),
            )
          ],
        ),
      ),
    );
  }
}
