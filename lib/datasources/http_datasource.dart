import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/datasources/dio_http_datasource.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class DioHttpDatasource implements HttpDatasource {
  final Dio _dio;

  DioHttpDatasource({required BaseOptions dioOptions}) : _dio = Dio(dioOptions);

  @override
  Future<dynamic> get({required String url}) async {
    try {
      final result = await _dio.get(url);
      return result.data;
    } on DioException catch (e) {
      _logDioException(e);
      throw handleDioException(e);
    }
  }

  void _logDioException(DioException e) {
    if (e.response != null) {
      debugPrint('Error Response Data: ${e.response!.data}');
      debugPrint('Error Response Headers: ${e.response!.headers}');
      debugPrint('Error Request Options: ${e.response!.requestOptions}');
    } else {
      debugPrint('Error Request Options: ${e.requestOptions}');
      debugPrint('Error Message: ${e.message}');
    }
  }

  String handleDioException(DioException e) {
    if (e.type == DioExceptionType.badResponse && e.response != null) {
      switch (e.response!.statusCode) {
        case 401:
          return AppStrings.error401;
        case 404:
          return AppStrings.error404;
        default:
          return AppStrings.errorDefault;
      }
    }
    return AppStrings.errorDefault;
  }
}
