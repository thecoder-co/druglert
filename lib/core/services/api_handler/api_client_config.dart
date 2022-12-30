import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:drug_alert_frontend/core/constants/app_endpoints.dart';
import 'package:drug_alert_frontend/core/services/local_data.dart';
import 'package:flutter/foundation.dart';

class BackendService {
  final Dio _dio;

  final String? otherBaseUrl;

  BackendService(this._dio, {this.otherBaseUrl}) {
    initializeDio();
  }

  /// This allows you set [header] options outside the backend service class
  void setExtraHeaders(Map<String, dynamic> newHeaders) {
    Map<String, dynamic> existingHeaders = _dio.options.headers;
    newHeaders.forEach((key, value) =>
        existingHeaders.update(key, (_) => value, ifAbsent: () => value));
    _dio.options.headers = existingHeaders;
  }

  void initializeDio() {
    //
    _dio.options = BaseOptions(
      baseUrl: otherBaseUrl ?? AppEndpoints.baseUrl,
      // set request headers
      headers: {
        'content-Type': 'application/json',
      },
    );

    //
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) {
        return true;
      };
      return null;
    };

    _dio.interceptors.add(
      InterceptorsWrapper(
          onRequest: onRequestInterceptors,
          onResponse: onResponseInterceptors,
          onError: onErrorInterceptorHandler),
    );
  }

  Future<void> setToken(RequestOptions option) async {
    String? token = LocalData.getInstance.token;
    token != null ? option.headers = {'Authorization': 'Bearer $token'} : null;
  }

  void onRequestInterceptors(RequestOptions options,
      RequestInterceptorHandler requestInterceptorHandler) async {
    await setToken(options);

    '======================================================================>';
    debugPrint('REQUEST URI ==============[🚀🚀🚀🚀]  ${options.uri}');
    debugPrint('REQUEST METHOD ==============[🚀🚀🚀🚀]  ${options.method}');
    debugPrint('REQUEST HEADERS ==============[🚀🚀🚀🚀] ${options.headers}',
        wrapWidth: 1024);
    debugPrint('REQUEST DATA ==============[🚀🚀🚀🚀] ${options.data}');
    log('${options.data}');
    '======================================================================>';
    // options.data = {
    //   'encryptedData': EncryptionService.encryptData(options.data),
    // };
    debugPrint('================================================>');
    debugPrint('=======[ENCRYPTED_PAYLOAD]=======');
    debugPrint('=======[INFO]: ${options.data}');
    debugPrint('================================================>');

    return requestInterceptorHandler.next(options); //continue
  }

  void onResponseInterceptors(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    '======================================================================>';
    debugPrint('RESPONSE DATA ==============>  ${response.data}');
    debugPrint('RESPONSE HEADERS ==============>  ${response.headers}');
    debugPrint('RESPONSE STATUSCODE ==============>  ${response.statusCode}');
    debugPrint(
        'RESPONSE STATUSMESSAGE ==============>  ${response.statusMessage}');
    '======================================================================>';
    return handler.next(response); // continue
  }

  dynamic onErrorInterceptorHandler(DioError e, handler) {
    return handler.next(e); //continue
  }

  /// This allows you change [baseurl] options outside the backend service class
  void changeBaseUrl(String newBaseUrl) => _dio.options.baseUrl = newBaseUrl;

  dynamic apiResponse(
      {dynamic message, dynamic errorCode, dynamic errorfield, dynamic data}) {
    return {
      'message': message ?? 'Something went wrong, Please try again later',
      'errorCode': errorCode ?? '000',
      'errorField': errorfield ?? 'null',
      'data': data
    };
  }

  Response? handleError(DioError? e) {
    // debugPrint(
    // "=============================[ALERT-😱😱😱]: ${e?.requestOptions.uri}");
    debugPrint(
        '=====================================[ALERT-😱😱😱]: ${e?.response?.data.toString()}');

    Response? response;

    debugPrint(
        'RESPONSE STATUSMESSAGE ==============>  ${e?.response?.statusCode}');
    debugPrint('${e?.response}=====================>>>>>>>>>>>>>>');

    switch (e?.type) {
      case DioErrorType.cancel:
        response = Response(
          data: apiResponse(
            message: 'Request cancelled!',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.connectTimeout:
        response = Response(
          data: apiResponse(
            message: 'Network connection timed out!',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.receiveTimeout:
        response = Response(
          data: apiResponse(
            message: 'Something went wrong. Please try again later!',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.sendTimeout:
        response = Response(
          data: apiResponse(
            message: 'Something went wrong. Please try again later',
          ),
          requestOptions: RequestOptions(path: ''),
        );
        break;
      case DioErrorType.other:
        if (e?.error is SocketException) {
          response = Response(
            data: apiResponse(
              message: 'Please check your network connection!',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e?.error is HttpException) {
          response = Response(
            data: apiResponse(
              message: 'Network connection issue',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        }
        break;
      default:
        if (e?.response?.data.runtimeType == String &&
            (e?.error.toString().contains('400') ?? false)) {
          response = Response(
            data: apiResponse(
              data: e?.response?.data,
              message: 'An error occurred, please try again',
              errorCode: '404',
            ),
            requestOptions: RequestOptions(path: ''),
          );
        } else if (e?.response?.data.runtimeType == String &&
            (e?.error.toString().contains('400') ?? false)) {
          try {
            response = Response(
              data: apiResponse(
                data: e?.response?.data,
                message: e?.response?.data['message'] ??
                    'An error occurred, please try again',
                errorfield: e?.response!.data['errorField'] ?? 'null',
                errorCode: '400',
              ),
              requestOptions: RequestOptions(path: ''),
            );
          } catch (e) {
            response = Response(
              data: apiResponse(
                message: 'An error occurred, please try again',
                errorCode: '400',
              ),
              requestOptions: RequestOptions(path: ''),
            );
          }
        } else {
          response = Response(
              data: apiResponse(
                  data: e?.response?.data,
                  message: e?.response!.data.isNotEmpty
                      ? e?.response!.data['message']
                      : 'NULL',
                  errorfield: e?.response!.data['errorField'] ?? 'null',
                  errorCode: e?.response!.data.isNotEmpty
                      ? e?.response!.data['errorCode']
                      : 'null'),
              statusCode: e?.response?.statusCode ?? 000,
              requestOptions: RequestOptions(path: ''));
        }
    }
    return response;
  }

  //
  Dio get dio => _dio;

  // Returns the same instance of dio throughout the application
  BackendService clone() => BackendService(_dio);

  dynamic runCall(Future<Response> data) async {
    try {
      return await data;
    } on DioError catch (e) {
      return handleError(e);
    }
  }

  Future<Response> uploadFormData(
    String endpoint, {
    required String method,
    dynamic data,
    Map<String, dynamic> customHeaders = const {},
    int? timeout,
  }) async {
    Dio dio = Dio();
    String? token = LocalData.getInstance.token;
    token != null
        ? dio.options.headers = {'Authorization': 'Bearer $token'}
        : null;
    // await setHeader();

    if (timeout != null) dio.options.connectTimeout = timeout;

    debugPrint((otherBaseUrl ?? AppEndpoints.baseUrl) + endpoint);
    var res = await dio.post(
      (otherBaseUrl ?? AppEndpoints.baseUrl) + endpoint,
      data: data,
    );
    debugPrint(
        '=========================++++++> STatus code ${res.statusCode} Message ${res.statusMessage}');

    debugPrint(res.toString());

    return res;
  }
}
