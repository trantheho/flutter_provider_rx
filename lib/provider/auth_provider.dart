
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_rx/commands/authenticate_command/check_login_command.dart';

class AuthProvider extends ChangeNotifier {

  AuthProvider(){
    checkLoginStatus();
  }

  bool _loading = true;

  bool get loading => _loading;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void updateLoggedIn(value){
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final _result = await CheckLoginCommand().run();
    _loading = false;
    _isLoggedIn = _result;
    notifyListeners();
  }
}