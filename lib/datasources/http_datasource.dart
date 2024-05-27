import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

abstract class HttpDatasource {
  Future<dynamic> getData({
    required String url,
  });
}

class HttpDatasourceImpl implements HttpDatasource {
  final Dio _client;

  HttpDatasourceImpl({required BaseOptions dioOptions})
      : _client = Dio(dioOptions);

  @override
  Future<dynamic> getData({required String url}) async {
    try {
      final result = await _client.get(url);
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
          return FiveflixStrings.error401;
        case 404:
          return FiveflixStrings.error404;
        default:
          return FiveflixStrings.errorDefault;
      }
    }
    return FiveflixStrings.errorDefault;
  }
}
