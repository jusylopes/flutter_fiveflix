import 'package:dio/dio.dart';

const baseUrlApi = 'https://api.themoviedb.org/3';
const apikey = '';
const String endpointPopularMovies = '$baseUrlApi/movie/popular';
const String endpointMovieDetail = '$baseUrlApi/movie/';
const String endpointPopularSeries = '$baseUrlApi/tv/popular';
const String endpointSerieDetail = '$baseUrlApi/tv/';
const String endpointSearch = '$baseUrlApi/search/movie?&query=';

final dioOptions = BaseOptions(
    baseUrl: baseUrlApi,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    contentType: 'application/json;charset=utf-8',
    queryParameters: {'api_key': apikey});
