import 'package:dio/dio.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

final dioOptions = BaseOptions(
    baseUrl: AppStrings.baseUrlApi,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: 'application/json;charset=utf-8',
    queryParameters: {'api_key': AppStrings.apikey});
