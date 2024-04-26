import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/core/service/login_service/login_service.dart';
import 'package:riverpod_example/core/utils/custom_toast.dart';
import 'package:riverpod_example/feature/login/model/login_request.dart';

final loginProvider = ChangeNotifierProvider((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  bool loginValidation(String email, String password) {
    if (email == "") {
      CustomToast.errorToast(message: "Email required");
      return false;
    }
    if (password == "") {
      CustomToast.errorToast(message: "Password required");
      return false;
    }

    return true;
  }

  Future doLoginApiCall(LoginRequest body) async {
    try {
      final response = await LoginService().doLogin(body);

      response.fold(
        (l) {
          CustomToast.errorToast(message: l.message ?? "");
        },
        (r) {
          CustomToast.successToast(message: "Welcome ${r.lastName}");
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
