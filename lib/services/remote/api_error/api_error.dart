import 'dart:io';

import 'package:dio/dio.dart';

abstract class BaseException implements Exception {}

class NetworkException extends BaseException {
  final String type;

  NetworkException(this.type);

  @override
  String toString() => 'Network error: $type';
}

class ResponseException extends BaseException {
  final String type;

  ResponseException(this.type);

  @override
  String toString() => 'Response error: $type';
}

/// Handle Error
class ApiError {
  static ApiError instance = ApiError._private();

  ApiError._private();

  BaseException checkError(dynamic error) {
    if (error is Exception) {
      try {
        BaseException _exception;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.CANCEL:
              _exception = NetworkException('Request Cancelled');
              break;
            case DioErrorType.CONNECT_TIMEOUT:
              _exception = NetworkException('Connection request timeout');
              break;
            case DioErrorType.DEFAULT:
              _exception = NetworkException('No internet connection');
              break;
            case DioErrorType.RECEIVE_TIMEOUT:
              _exception = NetworkException('Send timeout in connection with API server');
              break;
            case DioErrorType.RESPONSE:
              switch (error.response.statusCode) {
                case 400:
                case 401:
                case 403:
                  _exception = ResponseException('Unauthorised request');
                  break;
                case 404:
                  _exception = NetworkException('Not found');
                  break;
                case 409:
                  _exception = NetworkException('Error due to a conflict');
                  break;
                case 408:
                  _exception = NetworkException('Connection request timeout');
                  break;
                case 500:
                  _exception = NetworkException('Internal Server Error');
                  break;
                case 503:
                  _exception = NetworkException('Service unavailable');
                  break;
                default:
                  var responseCode = error.response.statusCode;
                  _exception = ResponseException("Received invalid status code: $responseCode");
              }
              break;
            case DioErrorType.SEND_TIMEOUT:
              _exception = NetworkException('Send timeout in connection with API server');
          }
        } else if (error is SocketException) {
          _exception = NetworkException('No internet connection');
        } else {
          _exception = NetworkException('Unexpected error occurred');
        }

        return _exception;
      } on FormatException catch (_) {
        return NetworkException('Unexpected error occurred');
      } catch (_) {
        return NetworkException('Unexpected error occurred');
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkException('Unable to process the data');
      } else {
        return NetworkException('Unexpected error occurred');
      }
    }
  }
}
