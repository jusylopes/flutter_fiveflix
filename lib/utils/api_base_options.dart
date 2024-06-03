import 'package:dio/dio.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

final dioOptionsTMDB = BaseOptions(
    baseUrl: FiveflixStrings.baseUrlApiTMDB,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: 'application/json;charset=utf-8',
    queryParameters: {'api_key': FiveflixStrings.apikey});

final dioOptionsGames = BaseOptions(
  baseUrl: FiveflixStrings.baseUrlApiGames,
  connectTimeout: const Duration(seconds: 5),
  receiveTimeout: const Duration(seconds: 5),
  contentType: 'application/json;charset=utf-8',
  
);
