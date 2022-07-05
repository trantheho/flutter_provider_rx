
import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_rx/commands/authenticate_command/login_command.dart';
import 'package:flutter_provider_rx/di/app_di.dart';
import 'package:flutter_provider_rx/internal/base/base_provider.dart';
import 'package:flutter_provider_rx/internal/utils/app_validation.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/models/user_model.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoginController {
  final screenLoading = BehaviorSubject<bool>(); //#local screen loading
  final phoneWarning = BehaviorSubject<String>();
  final passwordWarning = BehaviorSubject<String>();
  BuildContext context;

  String phoneNumber = '';
  String password = '';
  ValidationState phoneNumberState;
  ValidationState passwordState;

  List<Book> list = [
    Book(
      id: "1",
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Tây Du",
      subName: "The Ton Ngo Khong",
      bookmark: true,
    ),
    Book(
      id: "2",
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Vũ Canh Kỷ",
      subName: "The Vu Canh",
      bookmark: false,
    ),
    Book(
      id: "3",
      image: "https://photos.animetvn.tv/upload/film/006T5GTEly1ggmu3oerihj30u01hc7wi.png",
      name: "Nguyên Long",
      subName: "The Thor",
      bookmark: false,
    ),
  ];

  void dispose() {
    screenLoading.close();
    phoneWarning.close();
    passwordWarning.close();
  }

  Future<void> login({String phoneNumber, String password}) async {
    final _valid = validInput(phoneNumber: phoneNumber, password: password);
    if (_valid) {
      try {
        appController.loading.show();
        User user = await LoginCommand().run(
          email: phoneNumber,
          password: password,
        );

        _handleUserResult(user);
        appController.loading.hide();
      } catch (error) {
        appController.loading.hide();
        appController.dialog.showDefaultDialog(title: "Alert", message: error.toString());
      }
    }
  }

  void _handleUserResult(User user) {
    if (user == null) {
      appController.dialog.showDefaultDialog(context: context, title: "Alert", message: "User is null");
    }
    else{
      mainContext.read<MainProvider>().homeData.updatePopular = list;
      mainContext.read<AuthProvider>().updateLoggedIn(true);
    }
  }

  bool validInput({String phoneNumber, String password}) {
    phoneNumberState = Validation.instance.validatePhoneNumber(phoneNumber);
    passwordState = Validation.instance.validatePassword(password);

    _handleInvalidState(phoneNumber, password);

    //return phoneNumberState == ValidationState.valid && passwordState == ValidationState.valid;
    return true;
  }

  void _handleInvalidState(String phoneNumber, String password) {
    if(phoneNumberState == ValidationState.badPhoneNumber){
      if (phoneNumber.isEmpty) {
        phoneWarning.add("Phone number can not empty.");
      }
    }

    if(passwordState == ValidationState.badPassword){
      if (password.isEmpty) {
        passwordWarning.add("Password can not empty.");
      }
    }
  }
}
