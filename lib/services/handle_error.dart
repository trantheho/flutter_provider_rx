/*
 * Developed by Luc Nguyen on 7/2/20 5:20 PM.
 * Last modified 7/2/20 5:20 PM.
 * Copyright (c) 2020 Beesight Soft. All rights reserved.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_provider_rx/base/app_controller.dart';
import 'package:flutter_provider_rx/base/base_response.dart';
import 'package:flutter_provider_rx/response/error_response.dart';
import 'package:flutter_provider_rx/utils/app_helper.dart';

import '../my_app.dart';

class HandleError extends AppController {
  static HandleError instance = HandleError._private();

  HandleError._private();

  BaseError checkError<T>(dynamic error) {
    if (error is DioError) {
      if (error.response?.statusCode == 401) {
        final errorResponse = ErrorResponse(error.response.data);
        if (errorResponse.errors.first.code != 2005) {}
        _handleTokenExpired();
        return BaseError(code: errorResponse.errors.first.code, message: '');
      }
      if (error.type == DioErrorType.RESPONSE) {
        final errorResponse = ErrorResponse(error.response.data);
        return BaseError(
            code: errorResponse.errors.first.code,
            message: errorResponse.errors.first.message);
      }
      if (error.error is SocketException) if (error.error.osError != null) {
        if (error.error.osError?.errorCode == 8 ||
            error.error.osError?.errorCode == 7) {
          return BaseError(
              code: error.error.osError?.errorCode ?? -999,
              message: "network offline");
        } else {
          return BaseError(
              code: error.error.osError?.errorCode ?? -999,
              message: error.error.osError.message);
        }
      } else {
        if (!appController.alertTimeout) {
          appController.dialog.showDefaultDialog(
            title: "title",
            message: "message",
          );
        }
        return BaseError(
            code: error.error.osError?.errorCode ?? -999,
            message: 'Network error, please try again');
      }
    }
    if (error is TimeoutException) {
      if (!appController.alertTimeout) {
        appController.dialog.showDefaultDialog(
          title: "title",
          message: "message",
        );
      }
      return BaseError(code: -9999, message: 'Your request time out');
    }
    if (error is NoSuchMethodError) {
      return BaseError(code: -1, message: 'Error when getting data');
    }
    if (error is TypeError) {
      return BaseError(code: -2, message: 'Error when converting data');
    }
    if (error is HttpResponse) {
      if (error.statusCode >= 200 && error.statusCode <= 499) {
        if (error.statusCode == 401) {
          return BaseError(code: error.statusCode, message: 'Token Expired');
        }
      }
      return BaseError(
          code: error.statusCode,
          message: 'An error occurred, Please try again later');
    }

    return BaseError(code: -999, message: "error");
  }

  void _handleTokenExpired() {}
}
