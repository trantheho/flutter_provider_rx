import 'package:flutter_provider_rx/models/user_model.dart';
import 'package:flutter_provider_rx/usecase/app_usecase.dart';

class AuthenticateUseCase extends AppUseCase {

  ///
  Future<void> register(
      {String email, String password, dynamic userInfo}) async {}

  ///
  Future<User> login({
    String email,
    String password,
  }) async {
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

  ///
  Future<void> resetPassword({dynamic param}) async {}

  ///
  Future<void> forgotPassword({dynamic param}) async {}
}
