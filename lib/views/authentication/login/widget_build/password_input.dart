import 'package:flutter/material.dart';
import '../login_controller.dart';

class PasswordInput extends StatelessWidget {
  final Function(String) onTextChanged;
  final LoginController loginController;

  const PasswordInput({Key key, this.onTextChanged, this.loginController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: loginController.passwordWarning.stream,
      initialData: '',
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.number,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            suffixIcon: const Icon(Icons.visibility_off_outlined),
            //suffix: Icon(Icons.visibility_off_outlined),
            labelStyle: const TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w600,
            ),
            filled: true,
            fillColor: Colors.white,
            labelText: "Password",
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
                ),
            ),
            //errorText: snapshot.data,
            hintStyle: const TextStyle(
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
