import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/screens/authentication/login/login_controller.dart';
import 'package:flutter_provider_rx/screens/authentication/login/widget_build/password_input.dart';
import 'package:flutter_provider_rx/screens/authentication/login/widget_build/phone_number_input.dart';
import 'package:flutter_provider_rx/utils/app_helper.dart';
import 'package:flutter_provider_rx/widget/button.dart';
import 'package:flutter_provider_rx/widget/loading.dart';

class LoginScreen extends StatefulWidget {
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
    return AnnotatedRegion(
      value: AppHelper.statusBarOverlayUI(Brightness.dark),
      child: GestureDetector(
        onTap: () => AppHelper.hideKeyboard(context),
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
                      Spacer(),

                      PhoneNumberInput(
                        loginController: loginController,
                        onTextChanged: (phone){
                          loginController.phoneNumber = phone;
                        },
                      ),

                      SizedBox(height: 30,),

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
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.blueAccent,
                          ),
                          function: null,
                        ),
                      ),

                      Spacer(),

                      AppButton(
                        buttonText: "Login",
                        onPressed: (){
                          loginController.login(context, "email", "password");
                        },
                      ),

                      SizedBox(height: 10,),

                      _buildNewUser(),

                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
              StreamBuilder<bool>(
                stream: loginController.loading.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return snapshot.data ? AppLoading() : SizedBox();
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
        Text(
          "New user ?",
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueGrey,
          ),
        ),

        SizedBox(width: 10,),

        ButtonWithHighlightText(
          padding: EdgeInsets.zero,
            text: "Sign up",
            textStyle: TextStyle(
              fontSize: 14,
              color: Colors.blue,
            ),
            function: null,
        ),

      ],
    );
  }

}
