import 'package:dio/dio.dart';
import 'package:flutter_provider_rx/services/remote/dio_client.dart';

class UserService extends DioClient{
  Future<Response> login(
      {String email,
        String password,
        String deviceToken,
        String platform,
        String userId}) async {

    final String _url = '$baseApi/login';
    final Options _options = await getOptions();
    final _data = {
      "email": email,
      "password": password,
      'device_token':
      (deviceToken ?? '').isEmpty ? 'Device_Token' : deviceToken,
      'platform': platform ?? '',
      'app': 'user',
      'player_id': userId ?? '',
    };

    return dioWrapper(() => dio.post(_url, options: _options, data: _data));
  }

  Future<Response> logout() async {
    final String _url = '$baseApi/logout';
    final Options _options = await getAuthOptions();
    return dioWrapper(() => dio.get(_url, options: _options));
  }

  Future<Response> register({String email, String password, String firstName, String lastName, String confirmPassword}) async {
    final String _url = '$baseApi/register';
    final Options _options = await getOptions();
    final _data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };

    return dioWrapper(() => dio.post(_url, options: _options, data: _data));
  }
}