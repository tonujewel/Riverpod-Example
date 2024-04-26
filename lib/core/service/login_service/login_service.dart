import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../feature/login/model/login_request.dart';
import '../../../feature/login/model/login_response.dart';
import '../../model/error_model.dart';
import '../../network/dio_client.dart';
import '../../network/url_manager.dart';
import '../../utils/failures.dart';

class LoginService {
  Future<Either<ErrorModel, LoginResponse>> doLogin(LoginRequest body) async {
    try {
      final response = await DioClient().post(url: UrlManager.loginUrl, body: body.toJson());

      final loginResponse = loginResponseFromJson(response.toString());

      return Right(loginResponse);
    } on Failure catch (e) {
      ErrorModel errorModel = ErrorModel.fromJson(e.error);

      return Left(errorModel);
    }
  }
}

final loginProvide = Provider<LoginService>((ref) => LoginService());
