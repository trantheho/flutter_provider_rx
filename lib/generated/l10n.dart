// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello`
  String get hi {
    return Intl.message(
      'Hello',
      name: 'hi',
      desc: '',
      args: [],
    );
  }

  /// `Email is invalid`
  String get emailValid {
    return Intl.message(
      'Email is invalid',
      name: 'emailValid',
      desc: '',
      args: [],
    );
  }

  /// `username`
  String get userName {
    return Intl.message(
      'username',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get textContinue {
    return Intl.message(
      'continue',
      name: 'textContinue',
      desc: '',
      args: [],
    );
  }

  /// `get started`
  String get textGetStarted {
    return Intl.message(
      'get started',
      name: 'textGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Need Help?`
  String get textNeedHelp {
    return Intl.message(
      'Need Help?',
      name: 'textNeedHelp',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get textEmail {
    return Intl.message(
      'email',
      name: 'textEmail',
      desc: '',
      args: [],
    );
  }

  /// `Upload Hunt Images Here`
  String get uploadHuntImage {
    return Intl.message(
      'Upload Hunt Images Here',
      name: 'uploadHuntImage',
      desc: '',
      args: [],
    );
  }

  /// `required`
  String get required {
    return Intl.message(
      'required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get textLogin {
    return Intl.message(
      'Login',
      name: 'textLogin',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get textForgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'textForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Logo`
  String get textLogo {
    return Intl.message(
      'Logo',
      name: 'textLogo',
      desc: '',
      args: [],
    );
  }

  /// `Empty Screen`
  String get emptyScreen {
    return Intl.message(
      'Empty Screen',
      name: 'emptyScreen',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get store {
    return Intl.message(
      'Store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `My Bag`
  String get myBag {
    return Intl.message(
      'My Bag',
      name: 'myBag',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}