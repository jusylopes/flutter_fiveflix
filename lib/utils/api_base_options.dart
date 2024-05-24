import 'package:dio/dio.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

final dioOptions = BaseOptions(
    baseUrl: FiveflixStrings.baseUrlApi,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: 'application/json;charset=utf-8',
    queryParameters: {'api_key': FiveflixStrings.apikey});
