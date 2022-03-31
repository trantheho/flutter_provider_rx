import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_rx/internal/app_config.dart';
import 'package:flutter_provider_rx/services/local/hive_storage.dart';
import 'package:flutter_provider_rx/services/remote/api_error/api_error.dart';

class DioClient{
  final baseApi = AppConfig.instance.apiBaseUrl;
  Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.instance.apiBaseUrl,
    contentType: 'application/json',
    connectTimeout: 30000,
    sendTimeout: 30000,
    receiveTimeout: 30000,
  ));

  DioClient(){
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  Future<bool> _lookupInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty){
        return false;
      }
      else{
        return true;
      }
    } on SocketException catch (_) {
      return Future.error('internet is off');
    }
  }

  Future<Options> getOptions({String contentType = Headers.jsonContentType}) async {
    final Map<String, dynamic> _headers = await _getHeader();
    return Options(headers: _headers, contentType: contentType);
  }

  Future<Options> getAuthOptions({String contentType}) async {
    final Map<String, dynamic> _headers = await _getAuthorizedHeader();
    return Options(headers: _headers, contentType: contentType);
  }

  Future<Map<String, String>> _getHeader() async {
    return {
      "content-type": "application/json",
    };
  }

  Future<Map<String, String>> _getAuthorizedHeader() async {
    Map<String, String> _header = await _getHeader();
    String accessToken = await HiveStorage.instance.getAccessToken();
    _header.addAll({
      "Authorization": "Bearer $accessToken",
    });
    return _header;
  }

  Future<Response<dynamic>> dioWrapper(Future<Response> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (error) {
      throw ApiError.instance.checkError(error);
    }
  }
}