import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier{

  DateTime _expiry = DateTime.fromMillisecondsSinceEpoch(0);

  bool get isExpired => expiry.isBefore(DateTime.now());

  DateTime get expiry => _expiry;

}