import 'package:flutter/material.dart';
import 'package:flutter_provider_rx/screens/authentication/login/login_controller.dart';
import 'package:flutter_provider_rx/widget/divider_line.dart';

class PhoneNumberInput extends StatelessWidget {
  final Function(String) onTextChanged;
  final LoginController loginController;

  PhoneNumberInput({this.onTextChanged, this.loginController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: loginController.phoneWarning.stream,
      initialData: '',
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: Colors.white,
            labelText: "Phone Number",
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: snapshot.data.isNotEmpty ? Colors.red : Colors.grey,
                ),
              ),
            focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: snapshot.data.isNotEmpty ? Colors.red : Colors.blue,
                  )),
            //errorText: snapshot.data,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            //hintText: 'Your phone number',
          ),
          textAlign: TextAlign.start,
          onChanged: (value) => onTextChanged(value),
        );
      }
    );
  }
}
