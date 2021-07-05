/*
 * Developed by Ti Ti on 11/30/20 3:29 PM.
 * Last modified 11/30/20 3:29 PM.
 * Copyright (c) 2020. All rights reserved.
 */

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_provider_rx/services/local_storage/hive_storage.dart';

abstract class Api {
  final String appApiBaseUrl = 'api_url';//AppConstants.apiURL;
  final Dio dio = new Dio();

  Api() {
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
  }

  Future<void> _lookupInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty){
        return Future.error('internet is off');
      }
    } on SocketException catch (_) {
      return Future.error('internet is off');
    }
  }

  Future<Map<String, String>> getHeader() async {
    return {
      "content-type": "application/json",
    };
  }

  Future<Map<String, String>> getAuthorizedHeader() async {
    Map<String, String> _header = await getHeader();
    String accessToken = await HiveStorage.instance.getAccessToken();
    _header.addAll({
      "Authorization": "Bearer $accessToken",
    });
    return _header;
  }

  Future<Response<dynamic>> dioExceptionWrapper(Function() dioApi) async {
    try {
      await _lookupInternet();
      return await dioApi();
    } catch (error) {
      var errorMessage = error.toString();
      if (error is DioError && error.type == DioErrorType.RESPONSE) {
        final response = error.response;
        errorMessage = 'Code ${response.statusCode} - ${response.statusMessage} ${response.data != null ? '\n' : ''} ${response.data}';
        throw new DioError(
            request: error.request,
            response: error.response,
            type: error.type,
            error: errorMessage);
      }
      throw error;
    }
  }

}