
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/internal/utils/globals.dart';
import 'package:flutter_provider_rx/my_app.dart';

class DialogController{
  DialogController();

  //final _context = AppGlobals.currentState.overlay.context;

  /// network dialog
  void showNetworkDialog({BuildContext context, String title, String message}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppAlertDialog(title: title,message: message),
    );
  }

  /// normal dialog
  void showDefaultDialog({BuildContext context, String title, String message}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AppAlertDialog(title: title,message: message),
    );
  }

  /// confirm dialog
  void showConfirmDialog({BuildContext context, String title, String message, Function buttonOKCallback}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ConfirmAlertDialog(
        title: title,
        message: message,
        onOkPress: () => buttonOKCallback(),
      ),
    );
  }
}

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  const AppAlertDialog({Key key, this.title = "Alert", this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title ?? 'Alert'),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text("OK")),
      ],
    );
  }
}

class ConfirmAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function onOkPress;

  const ConfirmAlertDialog({
    Key key,
    this.title = "Alert",
    this.message,
    this.onOkPress,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message ?? ''),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            onOkPress();
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}