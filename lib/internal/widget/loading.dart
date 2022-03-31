import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class AppLoading extends StatelessWidget {
  const AppLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(40, 42, 62, 1).withAlpha(100),
                borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: SpinKitFadingCircle(color: Colors.white),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}