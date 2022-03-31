import 'package:flutter_provider_rx/commands/base_command.dart';
import 'package:flutter_provider_rx/models/user_model.dart';

class LoginCommand extends BaseCommand {
  Future<User> run({
    String email,
    String password,
  }) async {
    User _user;

    /*final response = userService.login(
      email: email,
      password: password,
    );*/

    await Future.delayed(Duration(seconds: 1));

    _user = User(name: "Chicken", age: "2", phone: "00000000");

    mainProvider.updateCurrentUser = _user;

    return mainProvider.currentUser;
  }
}