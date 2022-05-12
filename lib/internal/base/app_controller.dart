import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/router/app_router.dart';
import 'package:flutter_provider_rx/internal/utils/app_routes.dart';
import 'package:flutter_provider_rx/internal/widget/dialog.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:flutter_provider_rx/services/local/hive_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'base_provider.dart';

class AppController {
  final LoadingProvider _loading;
  final LocaleProvider _locale;
  final AppRouter _router;
  final DialogController _dialog;
  final HiveStorage _storage;
  final Toast _toast;

  AppController() :
    _loading = mainContext.read<LoadingProvider>(),
    _locale = mainContext.read<LocaleProvider>(),
    _router = AppRouter(mainContext.read<AuthProvider>()),
    _dialog = DialogController(),
    _storage = HiveStorage.instance,
    _toast = Toast();


  DialogController get dialog => _dialog;

  HiveStorage get storage => _storage;

  Toast get toast => _toast;

  LoadingProvider get loading => _loading;

  LocaleProvider get locale => _locale;

  AppRouter get router => _router;

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
