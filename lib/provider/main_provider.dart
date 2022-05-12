
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_rx/commands/base_command.dart';
import 'package:flutter_provider_rx/models/user_model.dart';
import 'package:flutter_provider_rx/provider/home_provider.dart';

class MainProvider extends ChangeNotifier {
  final List<String> _userPosts = [];
  final homeData = HomeProvider.init();


  List<String> get userPosts => _userPosts;

  User _currentUser;
  User get currentUser => _currentUser;

  set updateCurrentUser(User user){
    _currentUser = user;
    notifyListeners();
  }

  Future<User> getCurrentUser() async {
    User user;
    await Future.delayed(const Duration(seconds: 1));

    return user;
  }
}



