// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../utils/failures.dart';
import '../utils/pretty_dio_logger.dart';

// class DioClient {
//   static const int TIME_OUT_DURATION = 60;

//   Map<String, dynamic>? header = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//   };
//   //GET
//   Future<dynamic> get({
//     required String url,
//     Map<String, dynamic>? params,
//   }) async {
//     try {
//       var response = await Dio()
//           .get(url,
//               options: Options(
//                 headers: header,
//                 contentType: 'application/json',
//               ),
//               queryParameters: params)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       printResponse(url, "${header ?? ""}", "", "$response");

//       return response.data;
//     } catch (e) {
//       printResponse(url, "${header ?? ""}", '', "$e");
//       rethrow;
//     }
//   }

//   //POST

//   Future<dynamic> post({required String url, Map<String, dynamic>? params, dynamic body}) async {
//     var payload = json.encode(body);
//     try {
//       var response = await Dio()
//           .post(
//             url,
//             options: Options(headers: header),
//             queryParameters: params,
//             data: payload,
//           )
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       printResponse(url, "${header ?? ""}", "$body", "$response");
//       return jsonEncode(response.data);
//     } catch (e) {
//       log("catch ${e.toString()}");
//       printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
//       rethrow;
//     }
//   }

//   //PATCH

//   Future<dynamic> patch({required String url, Map<String, dynamic>? params, dynamic body}) async {
//     var payload = json.encode(body);
//     try {
//       var response = await Dio()
//           .patch(url, options: Options(headers: header), queryParameters: params, data: payload)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       printResponse(url, "${header ?? ""}", "$body", "$response");
//       return response.data;
//     } catch (e) {
//       printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
//       rethrow;
//     }
//   }

//   //DELETE

//   Future<dynamic> delete({required String url, Map<String, dynamic>? params, dynamic body}) async {
//     var payload = json.encode(body);
//     try {
//       var response = await Dio()
//           .delete(url, options: Options(headers: header), queryParameters: params, data: payload)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       printResponse(url, "${header ?? ""}", "$body", "$response");
//       return response.data;
//     } catch (e) {
//       printResponse(url, "${header ?? ""}", jsonEncode(body), "$e");
//       rethrow;
//     }
//   }

//   //MULTIPART FOR MULTIPLE FILE UPLOAD

//   List<File>? docFileList = [];
//   Future<dynamic> multipartRequest({
//     required String url,
//     Map<String, dynamic>? params,
//     required Map<String, dynamic> body,
//     String? filepath,
//   }) async {
//     var formData = FormData.fromMap(body);
//     for (var files in docFileList!) {
//       filepath = files.url;
//       formData.files.addAll([MapEntry("document[]", await MultipartFile.fromFile(filepath))]);
//     }

//     try {
//       var response = await Dio()
//           .post(url, options: Options(headers: header), queryParameters: params, data: formData)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       printResponse(url, "$header ", "$body", "$response");
//       return response.data;
//     } catch (e) {
//       printResponse(url, "$header", jsonEncode(body), "$e");
//       rethrow;
//     }
//   }

//   //MULTIPART FOR SINGLE FILE UPLOAD

//   Future<dynamic> multipartSingleFile(
//       {required String url,
//       Map<String, dynamic>? params,
//       required Map<String, dynamic> body,
//       String? filepath,
//       required String key}) async {
//     var formData = FormData.fromMap(body);
//     if (filepath != null) {
//       formData.files.add(MapEntry(key, await MultipartFile.fromFile(filepath)));
//     }

//     try {
//       var response = await Dio()
//           .post(url, options: Options(headers: header), queryParameters: params, data: formData)
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       printResponse(url, "$header ", "$body", "$response");
//       return response.data;
//     } catch (e) {
//       printResponse(url, "$header", jsonEncode(body), "$e");
//       rethrow;
//     }
//   }

//   Future<dynamic> downloadPdf({required String url, required String fileName}) async {
//     log("URL==> $fileName");
//     log("URL==> $url");

//     try {
//       var response = await Dio()
//           .download(
//             url,
//             fileName,
//             options: Options(headers: header),
//           )
//           .timeout(const Duration(seconds: TIME_OUT_DURATION));
//       log(response.toString());
//       return "";
//     } catch (e) {
//       rethrow;
//     }
//   }

//   void printResponse(String url, String header, String body, String response) {
//     log("START ============================================================");
//     log("URL : $url ");
//     log("HEADER : $header ");
//     log("BODY : $body ");
//     log("RESPONSE==> : $response <===");
//     log("END ============================================================");
//   }
// }

class DioClient {
  static final DioClient _instance = DioClient._internal();

  DioClient._internal();

  Map<String, dynamic>? header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  factory DioClient({
    int connectionTimeout = 30000,
    int receiveTimeout = 30000,
  }) {
    // _instance.baseUrl = baseUrl;
    // _instance.token = token;
    _instance.connectionTimeout = connectionTimeout;
    _instance.receiveTimeout = receiveTimeout;

    BaseOptions options = BaseOptions(
      // baseUrl: baseUrl,
      connectTimeout: Duration(milliseconds: connectionTimeout),
      receiveTimeout: Duration(milliseconds: receiveTimeout),
    );

    _instance._dio = Dio(options);
    return _instance;
  }

  late Dio _dio;
  late int connectionTimeout;
  late int receiveTimeout;
  late String baseUrl;
  late String token;

  Future<Response<dynamic>> get({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList();

    return _dio
        .get(url, queryParameters: query, options: Options(headers: header))
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    return _dio
        .post(
          url,
          data: body,
          options: Options(headers: header),
          queryParameters: query,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  /// Supports media upload
  Future<Response<dynamic>> postFormData(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    return _dio
        .post(
          url,
          data: FormData.fromMap(data),
          options: Options(headers: header),
          queryParameters: query,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> patch(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    return _dio
        .patch(
          url,
          data: data,
          options: Options(headers: header),
          queryParameters: query,
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> put(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    return _dio
        .put(url, data: data, options: Options(headers: header))
        .then((value) => value)
        .catchError(_handleException);
  }

  Future<Response<dynamic>> delete(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    return _dio
        .delete(
          url,
          data: data,
          queryParameters: query,
          options: Options(headers: header),
        )
        .then((value) => value)
        .catchError(_handleException);
  }

  /// Supports media upload
  Future<Response<dynamic>> putFormData(
    String url,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? query,
  }) async {
    _setDioInterceptorList();

    data.addAll({
      '_method': 'PUT',
    });

    return _dio
        .post(url,
            data: FormData.fromMap(data),
            queryParameters: query,
            options: Options(headers: header, contentType: 'multipart/form-data'))
        .then((value) => value)
        .catchError(_handleException);
  }

  /// Upload file in s3bucket
  Future<Response> fileUploadInS3Bucket({
    required String preAssignedUrl,
    required File file,
  }) async {
    return _dio.put(
      preAssignedUrl,
      data: file.openRead(),
      options: Options(
        headers: {
          Headers.contentLengthHeader: await file.length(),
        },
      ),
    );
  }

  dynamic _handleException(error) {
    dynamic errorData = error.response!.data;

    switch (error.response?.statusCode) {
      case 400:
        throw BadRequest(errorData);
      case 401:
        throw Unauthorized(errorData);
      case 403:
        throw Forbidden(errorData);
      case 404:
        throw NotFound(errorData);
      case 405:
        throw MethodNotAllowed(errorData);
      case 406:
        throw NotAcceptable(errorData);
      case 408:
        throw RequestTimeout(errorData);
      case 409:
        throw Conflict(errorData);
      case 410:
        throw Gone(errorData);
      case 411:
        throw LengthRequired(errorData);
      case 412:
        throw PreconditionFailed(errorData);
      case 413:
        throw PayloadTooLarge(errorData);
      case 414:
        throw URITooLong(errorData);
      case 415:
        throw UnsupportedMediaType(errorData);
      case 416:
        throw RangeNotSatisfiable(errorData);
      case 417:
        throw ExpectationFailed(errorData);
      case 422:
        throw UnprocessableEntity(errorData);
      case 429:
        throw TooManyRequests(errorData);
      case 500:
        throw InternalServerError(errorData);
      case 501:
        throw NotImplemented(errorData);
      case 502:
        throw BadGateway(errorData);
      case 503:
        throw ServiceUnavailable(errorData);
      case 504:
        throw GatewayTimeout(errorData);
      default:
        throw Unexpected(errorData);
    }
  }

  void _setDioInterceptorList() {
    List<Interceptor> interceptorList = [];
    _dio.interceptors.clear();

    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    _dio.interceptors.addAll(interceptorList);
  }

  // Future<Options> _getOptions(APIType api) async {
  //   switch (api) {
  //     case APIType.public:
  //       return PublicApiOptions().options;

  //     case APIType.protected:
  //       return ProtectedApiOptions(token).options;

  //     default:
  //       return PublicApiOptions().options;
  //   }
  // }
}
