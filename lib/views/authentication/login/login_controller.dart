
import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_rx/commands/authenticate_command/login_command.dart';
import 'package:flutter_provider_rx/main.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/models/user_model.dart';
import 'package:flutter_provider_rx/provider/auth_provider.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/provider/main_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoginController {
  final screenLoading = BehaviorSubject<bool>(); //#local screen loading
  final phoneWarning = BehaviorSubject<String>();
  final passwordWarning = BehaviorSubject<String>();

  String phoneNumber = '';
  String password = '';

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

  Future<void> login(BuildContext context, String phoneNumber, String password) async {
    if (validInput()) {
      try {
        appController.loading.show();
        User user = await LoginCommand().run(
          email: phoneNumber,
          password: password,
        );

        if (user != null) {
          context.read<MainProvider>().homeData.updatePopular = list;
          context.read<AuthProvider>().updateLoggedIn(true);
        }
        if (user == null) {
          appController.dialog.showDefaultDialog(title: "Alert", message: "User is null");
        }
        appController.loading.hide();
      } catch (error) {
        appController.loading.hide();
        appController.dialog.showDefaultDialog(title: "Alert", message: error.toString());
      }
    }
  }

  bool validInput() {
    bool value = true;
    if (phoneNumber.isEmpty) {
      phoneWarning.add("Phone number can not empty.");
      value = false;
    }

    if (password.isEmpty) {
      passwordWarning.add("Password can not empty.");
      value = false;
    }
    return value;
  }
}
