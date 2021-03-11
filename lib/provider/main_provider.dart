
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_rx/models/user_model.dart';

class MainProvider extends ChangeNotifier {
  List<String> _userPosts = [];
  List<String> get userPosts => _userPosts;


  User _currentUser;
  User get currentUser => _currentUser;

  set updateCurrentUser(User user){
    _currentUser = user;
    notifyListeners();
  }

  Future<User> getCurrentUser() async {
    User user;

    await Future.delayed(Duration(seconds: 1));

    return user;

  }
}

