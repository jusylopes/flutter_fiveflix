import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/datasources/dio_http_datasource.dart';

class DioHttpDatasource implements HttpDatasource {
  final Dio _dio;

  DioHttpDatasource({required BaseOptions dioOptions}) : _dio = Dio(dioOptions);

  @override
  Future<dynamic> get({required String url}) async {
    try {
      final result = await _dio.get(url);
      return result.data;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
      }
      rethrow;
    }
  }
}
