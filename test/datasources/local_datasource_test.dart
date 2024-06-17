import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_local_datasource_impl.mocks.dart';

void main() {
  late MockLocalDatasourceImpl localDatasource;

  setUp(() {
    localDatasource = MockLocalDatasourceImpl();
  });

  group('LocalDatasourceImpl Group Test |', () {
    test('Get returns null if key does not exist', () async {
      when(localDatasource.get('non_existing_key'))
          .thenAnswer((_) async => null);
      final result = await localDatasource.get('non_existing_key');
      expect(result, isNull);
    });

    test('Set and get should store and retrieve data correctly', () async {
      final Map<String, dynamic> testData = {'key': 'value'};
      const String testKey = 'lua_key';

      when(localDatasource.set(any, any)).thenAnswer((_) async => true);
      when(localDatasource.get(testKey)).thenAnswer((_) async => testData);

      await localDatasource.set(testKey, testData);
      final result = await localDatasource.get(testKey);

      expect(result, testData);
    });
  });
}
