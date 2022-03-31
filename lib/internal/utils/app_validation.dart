/*
 * Developed by Ti Ti on 11/17/20 1:41 PM.
 * Last modified 11/17/20 1:41 PM.
 * Copyright (c) 2020. All rights reserved.
 */

class Validation {
  static final instance = Validation._private();

  Validation._private();

  bool emailValidate(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return false;
    }
    return true;
  }

  bool validateName(String stringName, int length) {
    Pattern pattern =
        r"^([ a-zA-ZĂ€ĂĂ‚ĂƒĂˆĂ‰ĂĂŒĂĂ’Ă“Ă”Ă•Ă™ĂĂĂ Ă¡Ă¢Ă£Ă¨Ă©ĂªĂ¬Ă­Ă²Ă³Ă´ĂµĂ¹ĂºĂ½Ä‚ÄƒÄÄ‘Ä¨Ä©Å¨Å©Æ Æ¡Æ¯Æ°áº -á»¹]+(([',. -][a-zA-Z ])?[a-zA-ZĂ€ĂĂ‚ĂƒĂˆĂ‰ĂĂŒĂĂ’Ă“Ă”Ă•Ă™ĂĂĂ Ă¡Ă¢Ă£Ă¨Ă©ĂªĂ¬Ă­Ă²Ă³Ă´ĂµĂ¹ĂºĂ½Ä‚ÄƒÄÄ‘Ä¨Ä©Å¨Å©Æ Æ¡Æ¯Æ°áº -á»¹]*)*)$";
    if (stringName.isEmpty || stringName == '' || stringName == null) {
      return false;
    } else if (stringName.length > length) {
      return false;
    } else if (!RegExp(pattern).hasMatch(stringName)) {
      return false;
    }
    return true;
  }

}