// To parse this JSON data, do
//
//     final loginErrorResponse = loginErrorResponseFromJson(jsonString);

import 'dart:convert';

LoginErrorResponse loginErrorResponseFromJson(String str) => LoginErrorResponse.fromJson(json.decode(str));

String loginErrorResponseToJson(LoginErrorResponse data) => json.encode(data.toJson());

class LoginErrorResponse {
    final String? name;
    final int? code;
    final Error? error;

    LoginErrorResponse({
        this.name,
        this.code,
        this.error,
    });

    factory LoginErrorResponse.fromJson(Map<String, dynamic> json) => LoginErrorResponse(
        name: json["name"],
        code: json["code"],
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "error": error?.toJson(),
    };
}

class Error {
    final String? message;

    Error({
        this.message,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
