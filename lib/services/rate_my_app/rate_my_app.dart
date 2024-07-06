import 'package:flutter/widgets.dart';
import 'package:rate_my_app/rate_my_app.dart';

RateMyApp rateMyApp = RateMyApp(
  preferencesPrefix: 'rateMyApp_',
  minDays: 7,
  minLaunches: 10,
  remindDays: 7,
  remindLaunches: 10,
);

Function showRateDialog = (BuildContext context) => {
      rateMyApp.init().then((_) {
        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showRateDialog(
            context,
            title: 'アプリを評価してください',
            message: 'アプリを気に入っていただけましたか？評価をお願いします。',
            rateButton: '評価する',
            noButton: '結構です',
            laterButton: '後で',
          );
        }
      })
    };
