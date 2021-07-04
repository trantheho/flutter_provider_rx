
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/globals.dart';
import 'package:flutter_provider_rx/my_app.dart';

class DialogController{
  final BuildContext context;

  DialogController(this.context);

  /// network dialog
  void showNetworkDialog(String title, String message) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AppAlertDialog(title: title,message: message),
    );
  }

  /// normal dialog
  void showDefaultDialog({String title, String message}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AppAlertDialog(title: title,message: message),
    );
  }

  /// confirm dialog
  void showConfirmDialog({String title, String message, Function buttonOKCallback}) {
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
  final title;
  final message;

  const AppAlertDialog({Key key, this.title = "Alert", this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
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
  final title;
  final message;
  final onOkPress;

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