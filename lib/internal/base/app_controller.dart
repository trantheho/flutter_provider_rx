import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/utils/app_routes.dart';
import 'package:flutter_provider_rx/internal/widget/dialog.dart';
import 'package:flutter_provider_rx/services/local/hive_storage.dart';

import 'base_provider.dart';

class AppController extends BaseProvider {
  LoadingProvider get loading => getProvided();

  LocaleProvider get locale => getProvided();

  DialogController get dialog => DialogController();

  HiveStorage get storage => HiveStorage.instance;

  AppRoutes get routes => AppRoutes();

  Toast get toast => Toast();

  bool alertTimeout = false;

  void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();
}

class Toast {
  void showToast({@required BuildContext context, String content = '', TextStyle contentStyle}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: contentStyle,
        ),
      ),
    );
  }

  void showCustomToast({@required BuildContext context, @required SnackBar snackBar}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(snackBar);
  }
}
