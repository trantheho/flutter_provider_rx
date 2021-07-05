import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_rx/globals.dart';
import 'package:flutter_provider_rx/widget/dialog.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;

import 'app_constants.dart';

DateTime clickTime;

class AppHelper {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// set status bar style overlay ui
  static SystemUiOverlayStyle statusBarOverlayUI(Brightness androidBrightness) {
    SystemUiOverlayStyle statusBarStyle;
    if (Platform.isIOS)
      statusBarStyle = (androidBrightness == Brightness.light)
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark;
    if (Platform.isAndroid) {
      statusBarStyle = SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: androidBrightness ?? Brightness.light);
    }
    return statusBarStyle;
  }

  static void distinctClick({@required Function action}) {
    DateTime _now = DateTime.now();
    if (clickTime == null) {
      clickTime = _now;
      action();
    }
    if (_now.difference(clickTime).inSeconds < 1) return;
    clickTime = _now;
    action();
  }

  static void showBottomSheet(context, Widget child,
      [isScrollControlled = false]) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: isScrollControlled,
        builder: (context) {
          return isScrollControlled
              ? DraggableScrollableSheet(
                  initialChildSize: 0.6, // half screen on load
                  maxChildSize: 1, // full screen on scroll
                  minChildSize: 0.25,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return child;
                  },
                )
              : child;
        });
  }

  /// resize file
  static Future<File> resizeFile(File file) async {
    File newFile = file;
    while (await newFile.length() > AppConstants.imageMaxSize) {
      var decodedImage = await decodeImageFromList(newFile.readAsBytesSync());
      img.Image imageTemp = img.decodeImage(file.readAsBytesSync());
      img.Image resizedImg = img.copyResize(imageTemp,
          width: decodedImage.width ~/ 2, height: decodedImage.height ~/ 2);
      newFile = file..writeAsBytesSync(img.encodePng(resizedImg));
    }
    return newFile;
  }
}

/// Log utils
class Logging {
  static void log(dynamic data) {
    if (!kReleaseMode) print(data);
  }
}
