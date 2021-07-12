import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/globals.dart';
import 'package:flutter_provider_rx/provider/base/base_provider.dart';
import 'package:flutter_provider_rx/services/local_storage/hive_storage.dart';
import 'package:flutter_provider_rx/utils/app_routes.dart';
import 'package:flutter_provider_rx/widget/dialog.dart';
import 'package:toast/toast.dart';

class AppController with BaseProvider{

  LoadingProvider get loading => getProvided();

  LocaleProvider get locale => getProvided();

  final dialog = DialogController(AppGlobals.currentState.overlay.context);

  final storage = HiveStorage.instance;

  final routes = AppRoutes();

  bool alertTimeout = false;

  /// hide keyboard
  void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  void showToaster(String text, [BuildContext context]) {
    if (text.isEmpty) return;
    Toast.show(text,
        context == null ? AppGlobals.currentState.overlay.context : context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundRadius: 10,
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
        textColor: Colors.white);
  }
}

final appController = AppController();