/*
 * Developed by Nhan Cao on 10/25/19 5:09 PM.
 * Last modified 10/25/19 5:09 PM.
 * Copyright (c) 2019 Beesight Soft. All rights reserved.
 */

/*
{
    "error": true,
    "data": null,
    "errors": [
        {
            "code": 1029,
            "message": "User not found!."
        }
    ]
}
 */
import 'dart:convert';
import 'dart:core';

import 'metadata_response.dart';

abstract class BaseResponse<T> {
  bool error;
  T data;
  List<BaseError> errors;
  Meta meta;

  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  /// @nhancv 12/6/2019: Abstract json to data
  T jsonToData(Map<String, dynamic> fullJson);

  /// @nhancv 12/6/2019: Abstract data to json
  dynamic dataToJson(T data);

  /// @nhancv 12/6/2019: Parsing data to object
  parsing(Map<String, dynamic> fullJson) {
    error = fullJson["error"] ?? false;
    data = jsonToData(fullJson);
    errors = parseErrorList(fullJson);
    meta = fullJson['meta'] != null ? Meta.fromJson(fullJson['meta']) : null;
  }

  /// @nhancv 12/6/2019: Parse error list from server
  List<BaseError> parseErrorList(Map<String, dynamic> fullJson) {
    List errors = fullJson["errors"];
    return errors != null
        ? List<BaseError>.from(errors.map((x) => BaseError.fromJson(x)))
        : <BaseError>[];
  }

  /// @nhancv 12/6/2019: Data to json
  Map<String, dynamic> toJson() => {
        "error": error,
        "data": dataToJson(data),
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };

  static fromJson(decode) {}
}

class BaseResponseCXI {
  bool error;
  dynamic data;
  List<BaseErrorCXI> errors;

  BaseResponseCXI({
    this.error,
    this.data,
    this.errors,
  });

  factory BaseResponseCXI.fromJson(Map<String, dynamic> json) =>
      BaseResponseCXI(
        error: json["error"],
        data: json["data"],
        errors: json["errors"] != null && (json["errors"] as List).length != 0
            ? List<BaseErrorCXI>.from(
                json["errors"].map((x) => BaseErrorCXI.fromJson(x)))
            : <BaseErrorCXI>[],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data,
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class BaseErrorCXI {
  int code;
  String message;

  BaseErrorCXI({
    this.code,
    this.message,
  });

  factory BaseErrorCXI.fromJson(Map<String, dynamic> json) => BaseErrorCXI(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}

class BaseError {
  int code;
  String message;

  BaseError({
    this.code,
    this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) => BaseError(
        code: json["code"] ?? json["errorCode"] ?? -792,
        message: json["message"] ?? json["errorMessage"] ?? 'Error',
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
