import 'package:flutter_provider_rx/base/base_provider.dart';

class AuthProvider extends BaseProvider{

  DateTime _expiry = DateTime.fromMillisecondsSinceEpoch(0);

  bool get isExpired => expiry.isBefore(DateTime.now());

  DateTime get expiry => _expiry;

}