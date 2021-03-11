
import 'package:flutter_provider_rx/base/base_provider.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/models/user_model.dart';

class MainProvider extends BaseProvider {
  List<String> _userPosts = [];
  List<String> get userPosts => _userPosts;


  User _currentUser;
  User get currentUser => _currentUser;

  set updateCurrentUser(User user){
    _currentUser = user;
    notify();
  }

  Future<User> getCurrentUser() async {
    User user;

    await Future.delayed(Duration(seconds: 1));

    return user;

  }
}

