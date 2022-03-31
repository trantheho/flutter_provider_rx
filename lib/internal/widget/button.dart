/*
 * Developed by Cuong Truong on 6/8/20 11:22 AM.
 * Last modified 6/8/20 11:22 AM.
 * Copyright (c) 2020 BeeSight Soft. All rights reserved.
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';


class ButtonWidget {
  static Widget buildButtonWithHighlightText(
      {@required EdgeInsetsGeometry padding,
        @required String text,
        @required TextStyle textStyle,
        @required Function function,
        Color color,
        Color highlightedColor}) {
    return ButtonWithHighlightText(
      padding: padding,
      text: text,
      textStyle: textStyle,
      function: function,
      color: color,
      highlightedColor: highlightedColor,
    );
  }

  static Widget buildButtonWithHighlightIcon({
    @required dynamic icon,
    @required Function function,
    EdgeInsetsGeometry padding,
    Color color,
    Color highlightedColor,
    Size size,
  }) {
    return ButtonWithHighlightIcon(
      icon: icon,
      function: function,
      padding: padding,
      color: color,
      highlightedColor: highlightedColor,
      size: size,
    );
  }
}

// ignore: must_be_immutable
class ButtonWithHighlightText extends StatelessWidget {
  EdgeInsetsGeometry padding;
  String text;
  TextStyle textStyle;
  Color color;
  Color highlightedColor;
  Function function;
  double height;
  double width;
  final _highlight = BehaviorSubject<bool>();

  ButtonWithHighlightText(
      {@required this.text,
        @required this.textStyle,
        @required this.function,
        this.padding,
        this.color,
        this.highlightedColor,
        this.height,
        this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ButtonTheme(
        minWidth: 0,
        child: MaterialButton(
          padding: padding,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: function,
          child: StreamBuilder(
              stream: _highlight.stream,
              initialData: false,
              builder: (context, snapshot) {
                bool _highlighted = snapshot.hasData ? snapshot.data ?? false : false;
                Color _color = _highlighted
                    ? highlightedColor ?? Theme.of(context).colorScheme.primary
                    : color ?? Theme.of(context).colorScheme.secondary;
                return Text(
                  text,
                  style: textStyle.copyWith(color: _color),
                );
              }),
          onHighlightChanged: (highlighted) {
            _highlight.add(highlighted);
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonWithHighlightIcon extends StatelessWidget {
  dynamic icon;
  Function function;
  EdgeInsetsGeometry padding;
  MaterialTapTargetSize targetSize;
  Color color;
  Color highlightedColor;
  Size size;
  final _highlight = BehaviorSubject<bool>();

  ButtonWithHighlightIcon({
    @required this.icon,
    @required this.function,
    this.targetSize,
    this.padding,
    this.color,
    this.highlightedColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    //double _defaultSize = AppHelper.responsiveSize(context, value: 20);
    Size _size = size ?? Size(24, 24);
    Color _color = color ?? Theme.of(context).colorScheme.secondary;
    Color _highlightedColor = highlightedColor ?? Theme.of(context).colorScheme.primary;
    return ButtonTheme(
      minWidth: 0,
      child: FlatButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        materialTapTargetSize: targetSize ?? null,
        padding: padding,
        onPressed: function,
        child: StreamBuilder(
            stream: _highlight.stream,
            builder: (context, snapshot) {
              bool _highlighted = snapshot.hasData ? snapshot.data ?? false : false;
              Color _iconColor = _highlighted ? _highlightedColor : _color;
              return _getChild(
                icon,
                _iconColor,
                _size,
              );
            }),
        onHighlightChanged: (highlighted) {
          _highlight.add(highlighted);
        },
      ),
    );
  }

  Widget _getChild(dynamic icon, Color color, Size size) {
    Widget _widget = Icon(
      Icons.add,
      color: color,
      size: size.width,
    );
    if (icon != null) {
      if (icon is String && icon.contains('assets/drawables/icons/')) {
        _widget = Image.asset(
          '$icon',
          color: color,
          width: size.width,
          height: size.height,
        );
      } else if (icon is IconData) {
        _widget = Icon(
          icon,
          color: color,
          size: size.width,
        );
      }
    }
    return _widget;
  }
}

class AppButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final TextStyle style;
  final Function onPressed;

  AppButton({this.buttonColor, this.buttonText, this.style, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: buttonColor ?? Colors.blueAccent,
      ),
      child: RawMaterialButton(
        onPressed: () => onPressed(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Center(
          child: Text(
            buttonText ?? "button",
            style: style ?? TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}


