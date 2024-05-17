import 'package:dio/dio.dart';
import 'package:flutter_fiveflix/datasources/dio_http_datasource.dart';

class DioHttpDatasource implements HttpDatasource {
  final Dio _dio;

  DioHttpDatasource({required BaseOptions dioOptions}) : _dio = Dio(dioOptions);

  @override
  Future<dynamic> get(String url) async {
    try {
      final result = await _dio.get(url);
      return result.data;
    } catch (e) {
      rethrow;
    }
  }
}
