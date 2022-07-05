/*
 * Developed by Ti Ti on 11/17/20 1:41 PM.
 * Last modified 11/17/20 1:41 PM.
 * Copyright (c) 2020. All rights reserved.
 */

enum ValidationState{
  valid,
  badEmail,
  badPhoneNumber,
  badPassword,
}


class Validation {
  static final instance = Validation._private();
  Validation._private();

  static const emailRegex = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const passwordRegex = r"^([ a-zA-ZĂ€ĂĂ‚ĂƒĂˆĂ‰ĂĂŒĂĂ’Ă“Ă”Ă•Ă™ĂĂĂ Ă¡Ă¢Ă£Ă¨Ă©ĂªĂ¬Ă­Ă²Ă³Ă´ĂµĂ¹ĂºĂ½Ä‚ÄƒÄÄ‘Ä¨Ä©Å¨Å©Æ Æ¡Æ¯Æ°áº -á»¹]+(([',. -][a-zA-Z ])?[a-zA-ZĂ€ĂĂ‚ĂƒĂˆĂ‰ĂĂŒĂĂ’Ă“Ă”Ă•Ă™ĂĂĂ Ă¡Ă¢Ă£Ă¨Ă©ĂªĂ¬Ă­Ă²Ă³Ă´ĂµĂ¹ĂºĂ½Ä‚ÄƒÄÄ‘Ä¨Ä©Å¨Å©Æ Æ¡Æ¯Æ°áº -á»¹]*)*)$";

  ValidationState validateEmail(String email) {
    final regex = RegExp(emailRegex);
    if (!regex.hasMatch(email)) {
      return ValidationState.badEmail;
    }
    return ValidationState.valid;
  }

  ValidationState validatePhoneNumber(String phone){
    if(phone == null) {
      return ValidationState.badPhoneNumber;
    } else if(phone.isEmpty) {
      return ValidationState.badPhoneNumber;
    }
    else if(phone.length <9){
      return ValidationState.badPhoneNumber;
    }

    return ValidationState.valid;
  }

  ValidationState validateName(String stringName, int length) {
    if (stringName.isEmpty || stringName == '' || stringName == null) {
      return ValidationState.badPassword;
    } else if (stringName.length > length) {
      return ValidationState.badPassword;
    } else if (!RegExp(passwordRegex).hasMatch(stringName)) {
      return ValidationState.badPassword;
    }
    return ValidationState.valid;
  }

  ValidationState validatePassword(String password){
    if(password == null) {
      return ValidationState.badPassword;
    } else if(password.isEmpty) {
      return ValidationState.badPassword;
    }
    else if(password.length <8){
      return ValidationState.badPassword;
    }

    return ValidationState.valid;
  }

}