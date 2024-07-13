import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../features/greeting/providers/hello_world_provider.dart';
import '../../../routes/router.dart';
import '../../../services/analytics/events.dart';
import '../../../services/environment/environment.dart';
import '../../../services/rate_my_app/rate_my_app.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key}) {
    AnalyticsEventService().logPage(ScreenName.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String greeting = ref.watch(helloWorldProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 88, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home Page',
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
                context.goNamed(RouteNames.homeLoginName);
              },
              child: const Text('Go to Login Page'),
            ),
            TextButton(
              onPressed: () {
                context.go(Routes.settingRoute);
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
            ),
            const SizedBox(height: 16),
            const Text('Riverpod 検証'),
            Text(greeting),
            const SizedBox(height: 16),
            const Text('Push 通知権限要求'),
            TextButton(
              onPressed: () async {
                final messaging = FirebaseMessaging.instance;
                await messaging.requestPermission(
                  alert: true,
                  announcement: false,
                  badge: true,
                  carPlay: false,
                  criticalAlert: false,
                  provisional: false,
                  sound: true,
                );

                final token = await messaging.getToken();
                if (kDebugMode) {
                  print('🐯 FCM TOKEN: $token');
                }
              },
              child: const Text('Request Push Notification Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
