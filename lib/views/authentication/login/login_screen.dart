import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/di/app_di.dart';
import 'package:flutter_provider_rx/internal/utils/app_helper.dart';
import 'package:flutter_provider_rx/internal/utils/styles.dart';
import 'package:flutter_provider_rx/internal/widget/button.dart';
import 'package:flutter_provider_rx/internal/widget/loading.dart';

import 'login_controller.dart';
import 'widget_build/password_input.dart';
import 'widget_build/phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = LoginController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    loginController.context = context;
    return AnnotatedRegion(
      value: AppHelper.statusBarOverlayUI(Brightness.dark),
      child: GestureDetector(
        onTap: () => appController.hideKeyboard(context),
        child: Scaffold(
          body: Stack(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),

                      PhoneNumberInput(
                        loginController: loginController,
                        onTextChanged: (phone){
                          loginController.phoneNumber = phone;
                        },
                      ),

                      const SizedBox(height: 30,),

                      PasswordInput(
                        loginController: loginController,
                        onTextChanged: (password){
                          loginController.password = password;
                        },
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        child: ButtonWithHighlightText(
                          padding: EdgeInsets.zero,
                          text: "Forgot Password?",
                          textStyle: AppTextStyle.normal.copyWith(color: Colors.blueAccent),
                          function: null,
                        ),
                      ),

                      const Spacer(),

                      AppButton(
                        buttonText: "Login",
                        onPressed: (){
                          loginController.login(phoneNumber: loginController.phoneNumber, password: loginController.password);
                        },
                      ),

                      const SizedBox(height: 10,),

                      _buildNewUser(),

                      const SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
              StreamBuilder<bool>(
                stream: loginController.screenLoading.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return snapshot.data ? const AppLoading() : const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewUser(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "New user ?",
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueGrey,
          ),
        ),

        const SizedBox(width: 10,),

        ButtonWithHighlightText(
          padding: EdgeInsets.zero,
            text: "Sign up",
            textStyle: AppTextStyle.normal,
            function: null,
        ),

      ],
    );
  }

}
