import 'dart:async';
import 'package:dio/dio.dart';
import 'package:providerskel/data/models/error_model.dart';
import 'package:providerskel/helpers/api_const.dart';

class ApiHelper {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveTimeout: DevEnv.receiveTimeout,
      connectTimeout: DevEnv.connectTimeout,
      contentType: "application/json",
      validateStatus: (int? status) {
        return status != null;
      },
    ),
  );

  ApiHelper();

  Future<Object> get(String url,
      {String? data,
      Map<String, dynamic>? header,
      Map<String, dynamic>? queryParameter}) async {
    try {
      var response = await _dio.get(
        queryParameters: queryParameter,
        url,
        options: Options(headers: header),
      );
      // print(response);

      return response;
    } catch (e) {
      return handleError(e);
    }
  }

  Future<Object> put(String url,
      {Map<String, dynamic>? data,
      Map<String, dynamic>? header,
      Map<String, dynamic>? queryParameter}) async {
    try {
      print(url);
      var response = await _dio.put(
        data: data,
        queryParameters: queryParameter,
        url,
        options: Options(headers: header),
      );
      // print(response);

      return response;
    } catch (e) {
      return handleError(e);
    }
  }

  Future<Object> post(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
  }) async {
    try {
      var response = await _dio.post(
        _dio.options.baseUrl + url,
        data: data,
        options: Options(headers: header),
      );
      print("response$response");
      return response;
    } catch (e) {
      return handleError(e);
    }
  }

  Future<Object> delete(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
  }) async {
    print(_dio.options.baseUrl + url);
    try {
      var response = await _dio.delete(
        _dio.options.baseUrl + url,
        data: data,
        options: Options(headers: header),
      );

      return response;
    } catch (e) {
      return handleError(e);
    }
  }

  Future<Object> patch(
    String url, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
  }) async {
    try {
      var response = await _dio.patch(
        _dio.options.baseUrl + url,
        data: data,
        options: Options(headers: header),
      );

      return response;
    } catch (e) {
      return handleError(e);
    }
  }

  Future<ErrorModel> handleError(dynamic error) async {
    ErrorModel errorModel = ErrorModel();
    errorModel.message = error.toString();
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.sendTimeout:
          errorModel.description = "Timed out";
          break;
        case DioExceptionType.cancel:
          errorModel.description = "Cancelled";
          break;
        case DioExceptionType.badResponse:
          errorModel.description = "Bad Response";
          break;
        case DioExceptionType.unknown:
          errorModel.description = "Unknown";
          break;
        case DioExceptionType.receiveTimeout:
          errorModel.description = "Timed Out";
          break;
        case DioExceptionType.connectionTimeout:
          errorModel.description = "Timed Out";
          break;
        case DioExceptionType.badCertificate:
          errorModel.description = "Bad Cert";
          break;
        case DioExceptionType.connectionError:
          errorModel.description = "Connection Error";
          break;
      }
    }
    return errorModel;
  }
}

class DevEnv {
  static const receiveTimeout = Duration(seconds: 10);
  static const connectTimeout = Duration(seconds: 10);
}
