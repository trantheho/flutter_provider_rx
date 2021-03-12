import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_provider_rx/utils/app_helper.dart';
import 'api.dart';

class AuthenticationApi extends Api{

  static AuthenticationApi instance = AuthenticationApi._private();
  AuthenticationApi._private();

  /// login
  Future<Response> login(
      {String email,
      String password,
      String deviceToken,
      String platform,
      String userId}) async {

    Logging.log(json.encode({
      "email": email,
      "password": password,
    }));

    final String _url = '$appApiBaseUrl/login';
    final Map<String, dynamic> _headers = await getHeader();
    final Options _options = Options(headers: _headers);
    final _data = {
      "email": email,
      "password": password,
      'device_token':
          (deviceToken ?? '').isEmpty ? 'Device_Token' : deviceToken,
      'platform': platform ?? '',
      'app': 'user',
      'player_id': userId ?? '',
    };

    return dioExceptionWrapper(
        () => dio.post(_url, options: _options, data: _data));
  }

  /// logout
  Future<Response> logout() async {

    final String _url = '$appApiBaseUrl/logout';
    final Map<String, dynamic> _headers = await getAuthorizedHeader();
    final Options _options = Options(headers: _headers);

    return dioExceptionWrapper(() => dio.get(_url, options: _options));
  }

  /// register
  Future<Response> register({String email, String password, String firstName, String lastName, String confirmPassword}) async {
    Logging.log(json.encode({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    }));

    final String _url = '$appApiBaseUrl/register';
    final Map<String, dynamic> _headers = await getHeader();
    final Options _options = Options(headers: _headers);
    final _data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    return dioExceptionWrapper(() => dio.post(_url, options: _options, data: _data));
  }

  /// resendActivationEmail
  Future<Response> resendActivationEmail({String email}) async {
    Logging.log(json.encode({
      'email': email,
    }));

    final String _url = '$appApiBaseUrl/account/resend-activation-code';
    final Map<String, dynamic> _headers = await getHeader();
    final Options _options = Options(headers: _headers);
    final _data = {
      'email': email,
    };

    return dioExceptionWrapper(() => dio.post(_url, options: _options, data: _data));
  }

  /// resendActivationEmail
  Future<Response> resetPassword({String email}) async {
    Logging.log(json.encode({
      'email': email,
    }));

    final String _url = '$appApiBaseUrl/password/send?email=$email';
    final Map<String, dynamic> _headers = await getHeader();
    final Options _options = Options(headers: _headers);


    return dioExceptionWrapper(() => dio.post(_url, options: _options));
  }




}