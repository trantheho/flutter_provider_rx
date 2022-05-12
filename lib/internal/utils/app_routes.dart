import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  /// Navigate push with callback
  void push(context, String screenName, Widget screen, [Function(Object) callback]) {
    if (context == null) return;
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) =>
        screen,
          settings: RouteSettings(name: screenName),
        )
    ).then((data) {
      if (data != null && callback != null) {
        callback(data);
      }
    });
  }

  /// Navigate replace
  void replace(context, String screenName, Widget screen, {Object result}) {
    if (context == null) return;
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) =>
        screen,
          settings: RouteSettings(name: screenName),
        ),
        result: result);
  }

  /// Pop to screen in stack
  void popTo(context, String screenName, Widget screen) {
    if (context == null) return;
    Navigator.of(context).popUntil((route) {
      return route.settings.name == screenName;
    });
  }

  /// Navigate push and remove previous stack
  void pushAndRemoveUntil(context, String screenName, Widget screen) {
    if (context == null) return;
    Navigator.pushAndRemoveUntil(context,
        CupertinoPageRoute(builder: (context) =>
        screen,
          settings: RouteSettings(name: screenName),
        ), (Route<dynamic> route) => false);
  }

  /// Pop to first screen in stack
  void popToFirst(context) {
    if (context == null) return;
    Navigator.of(context).popUntil((route) {
      return route.isFirst;
    });
  }

}