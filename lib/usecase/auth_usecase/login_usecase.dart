
import 'package:flutter_provider_rx/models/user_model.dart';
import 'package:flutter_provider_rx/service/app_api.dart';
import 'package:flutter_provider_rx/usecase/app_usecase.dart';

class LoginUseCase extends AppUseCase {

  Future<User> execute({String email, String password,}) async {
    User _user;

    /*final response = AppApi.authen.login(
      email: email,
      password: password,
    ).timeout(Duration(seconds: 30));*/

    await Future.delayed(Duration(seconds: 1));

    _user = User(name: "Chicken", age: "2", phone: "00000000");

    mainProvider.updateCurrentUser = _user;

    return mainProvider.currentUser;

  }

}