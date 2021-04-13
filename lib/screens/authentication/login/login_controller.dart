import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_rx/models/book_model.dart';
import 'package:flutter_provider_rx/models/user_model.dart';
import 'package:flutter_provider_rx/provider/book_provider.dart';
import 'package:flutter_provider_rx/service/handle_error.dart';
import 'package:flutter_provider_rx/usecase/auth_usecase/login_usecase.dart';
import 'package:flutter_provider_rx/utils/app_helper.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';


class LoginController {
  final loading = BehaviorSubject<bool>();
  final phoneWarning = BehaviorSubject<String>();
  final passwordWarning = BehaviorSubject<String>();

  String phoneNumber = '';
  String password = '';

  List<Book> list = [
    Book(
      id: "1",
      image: "http://cdn5.truyentranh8.net/u/ngocph301/11260-tay-du/079-272767/001.jpg",
      name: "Tây Du",
      subName: "The Ton Ngo Khong",
      bookmark: true,
    ),
    Book(
      id: "2",
      image:
          "https://img.vncdn.xyz/storage20/hh247/images/vu-canh-ky-2-f2689.jpg",
      name: "Vũ Canh Kỷ",
      subName: "The Vu Canh",
      bookmark: false,
    ),
    Book(
      id: "3",
      image: "https://img.tvzingvn.net/uploads/2020/07/5f0a3c90acc3999-35268.jpg",
      name: "Nguyên Long",
      subName: "The Thor",
      bookmark: false,
    ),
  ];


  void dispose(){
    loading.close();
    phoneWarning.close();
    passwordWarning.close();
  }

  Future<void> login(
      BuildContext context, String phoneNumber, String password) async {

    if(validInput()){
      try {
        loading.add(true);
        User user = await LoginUseCase()
            .execute(email: phoneNumber, password: password);

        loading.add(false);

        if(user != null){
          context.read<BookProvider>().updatePopular = list;
        }

        if(user == null){
          AppHelper.showAppDialog("Alert", "User is null");
        }

      } catch (error) {
        loading.add(false);
        final message = HandleError.instance.checkError(error);
        print("error message: $message");
      }
    }
    else
      return;
  }

  bool validInput(){
    bool value = true;
    if(phoneNumber.isEmpty){
      phoneWarning.add("Phone number can not empty.");
      value = false;
    }

    if(password.isEmpty){
      passwordWarning.add("Password can not empty.");
      value = false;
    }
    return value;
  }

}