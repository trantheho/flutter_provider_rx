import 'package:flutter/material.dart';

abstract class BaseProvider extends ChangeNotifier{
  void notify() => notifyListeners();
}