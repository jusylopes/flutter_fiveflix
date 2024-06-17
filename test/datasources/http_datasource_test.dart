import 'package:dio/dio.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_dio.mocks.dart';
import '../mocks/mock_http_datasource.mocks.dart';

void main() {
  late MockDio mockDio;
  late MockHttpDatasource mockHttpDatasource;
  const String testUrl = 'https://lua.com';

  setUpAll(() {
    mockDio = MockDio();
    mockHttpDatasource = MockHttpDatasource();
  });

  group('HttpDatasourceImpl Group Test |', () {
    test('returns data if the http call completes successfully', () async {
      final responseData = {'key': 'value'};
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(mockDio.get(testUrl)).thenAnswer((_) async => response);
      when(mockHttpDatasource.getData(url: testUrl))
          .thenAnswer((_) async => responseData);

      final result = await mockHttpDatasource.getData(url: testUrl);
      expect(result, responseData);
    });

    test('throws error 401 if the http call completes with 401 error',
        () async {
      final response = Response(
        data: 'Unauthorized',
        statusCode: 401,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(mockDio.get(testUrl)).thenThrow(DioException(
        requestOptions: RequestOptions(path: testUrl),
        response: response,
        type: DioExceptionType.badResponse,
      ));

      when(mockHttpDatasource.getData(url: testUrl))
          .thenThrow(FiveflixStrings.error401);

      expect(
        () async => await mockHttpDatasource.getData(url: testUrl),
        throwsA(FiveflixStrings.error401),
      );
    });

    test('throws error 404 if the http call completes with 404 error',
        () async {
      final response = Response(
        data: 'Not Found',
        statusCode: 404,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(mockDio.get(testUrl)).thenThrow(DioException(
        requestOptions: RequestOptions(path: testUrl),
        response: response,
        type: DioExceptionType.badResponse,
      ));

      when(mockHttpDatasource.getData(url: testUrl))
          .thenThrow(FiveflixStrings.error404);

      expect(
        () async => await mockHttpDatasource.getData(url: testUrl),
        throwsA(FiveflixStrings.error404),
      );
    });

    test('throws default error if the http call completes with another error',
        () async {
      final response = Response(
        data: 'Internal Server Error',
        statusCode: 500,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(mockDio.get(testUrl)).thenThrow(DioException(
        requestOptions: RequestOptions(path: testUrl),
        response: response,
        type: DioExceptionType.badResponse,
      ));

      when(mockHttpDatasource.getData(url: testUrl))
          .thenThrow(FiveflixStrings.errorDefault);

      expect(
        () async => await mockHttpDatasource.getData(url: testUrl),
        throwsA(FiveflixStrings.errorDefault),
      );
    });
  });
}
