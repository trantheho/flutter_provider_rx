import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/router/app_router.dart';
import 'package:flutter_provider_rx/internal/utils/app_routes.dart';
import 'package:flutter_provider_rx/internal/widget/dialog.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:flutter_provider_rx/services/local/hive_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'base/base_provider.dart';

class AppController {
  final LoadingManager _loading;
  final LocaleProvider _locale;
  final AppRouter _router;
  final DialogController _dialog;
  final HiveStorage _storage;
  final Toast _toast;

  AppController()
      : _locale = mainContext.read<LocaleProvider>(),
        _router = AppRouter(mainContext.read<AuthProvider>()),
        _storage = HiveStorage.instance,
        _dialog = DialogController(),
        _loading = LoadingManager(),
        _toast = Toast();

  DialogController get dialog => _dialog;

  HiveStorage get storage => _storage;

  Toast get toast => _toast;

  LoadingManager get loading => _loading;

  LocaleProvider get locale => _locale;

  AppRouter get router => _router;

  bool alertTimeout = false;

  void hideKeyboard(BuildContext context) => FocusScope.of(context).unfocus();
}

class Toast {
  void showToast({@required BuildContext context, String message = '', TextStyle textStyle}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: textStyle ?? const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  void showCustomToast({@required BuildContext context, @required SnackBar snackBar}) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(snackBar);
  }
}
