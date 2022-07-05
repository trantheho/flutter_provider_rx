import 'dart:math';

import 'package:flutter_provider_rx/internal/utils/app_validation.dart';
import 'package:flutter_provider_rx/views/authentication/login/login_controller.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group("validation", (){
    final loginController = LoginController();
    testPhoneNumber(loginController);
    testPassword(loginController);
  });
}

void testPhoneNumber(LoginController loginController) {
  group("phone number", () {
    final _phoneNumberData = {
      '',
      '09090',
    };
    for (var phoneNumber in _phoneNumberData) {
      test(phoneNumber, () async {
        await loginController.login(phoneNumber: phoneNumber, password: '');
        expect(loginController.phoneNumberState, ValidationState.badPhoneNumber);
      });
    }
  });
}

void testPassword(LoginController loginController) {
  group("password", (){
    final _passwordData = {
      '',
      '  ',
      'sandk'
    };

    for(var password in _passwordData){
      test(password, () async {
        await loginController.login(phoneNumber: '09209', password: password);
        expect(loginController.passwordState, ValidationState.badPassword);
      });
    }
  });
}
