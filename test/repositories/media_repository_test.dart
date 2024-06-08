import 'package:flutter_fiveflix/datasources/http_datasource.dart';
import 'package:flutter_fiveflix/datasources/local_datasource.dart';
import 'package:flutter_fiveflix/models/media_model.dart';
import 'package:flutter_fiveflix/repositories/check_internet_use_case.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'media_repository_test.mocks.dart';

@GenerateMocks([HttpDatasource, LocalDatasource, CheckInternetUsecase])
void main() {
  group('MediaRepository Tests |', () {
    late MediaRepository mediaRepository;
    late MockHttpDatasource mockHttpDatasource;
    late MockLocalDatasource mockLocalDatasource;
    late MockCheckInternetUsecase mockCheckInternetUsecase;
    const String endpoint = 'url';
    const String keyJson = 'results';

    setUp(() {
      mockHttpDatasource = MockHttpDatasource();
      mockLocalDatasource = MockLocalDatasource();
      mockCheckInternetUsecase = MockCheckInternetUsecase();
      mediaRepository = MediaRepository(
        datasource: mockHttpDatasource,
        localDatasource: mockLocalDatasource,
        checkInternetUsecase: mockCheckInternetUsecase,
      );
    });

    test('Successfully get data with internet', () async {
      when(mockCheckInternetUsecase.call())
          .thenAnswer((_) => Future.value(true));

      when(mockHttpDatasource.getData(url: endpoint))
          .thenAnswer((_) async => jsonMockMedias);

      final medias = await mediaRepository.getListMedia(
        endpoint: endpoint,
        fromJson: (json) => MediaModel.fromJson(json),
        keyJson: keyJson,
      );

      expect(medias, isA<List<MediaModel>>());
      final MediaModel result = medias[0];
      expect(result.title, "Kingdom of the Planet of the Apes");
      expect(result.id, 653346);
    });

    test('Successfully save local data with internet', () async {
      when(mockCheckInternetUsecase.call())
          .thenAnswer((_) => Future.value(true));
      when(mockHttpDatasource.getData(url: endpoint))
          .thenAnswer((_) async => jsonMockMedias);

      await mediaRepository.getListMedia(
        endpoint: endpoint,
        fromJson: (json) => MediaModel.fromJson(json),
        keyJson: keyJson,
      );

      verify(mockLocalDatasource.set(endpoint, jsonMockMedias)).called(1);
    });

    test('Empty list if no internet and no local data', () async {
      when(mockCheckInternetUsecase.call())
          .thenAnswer((_) => Future.value(false));

      when(mockLocalDatasource.get(endpoint)).thenAnswer((_) async => null);

      var result = await mediaRepository.getListMedia(
        endpoint: endpoint,
        fromJson: (json) => MediaModel.fromJson(json),
        keyJson: keyJson,
      );

      expect(result, isEmpty);
    });
  });
}

const jsonMockMedias = {
  "results": [
    {
      "adult": false,
      "backdrop_path": "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg",
      "genre_ids": [878, 12, 28],
      "id": 653346,
      "original_language": "en",
      "original_title": "Kingdom of the Planet of the Apes",
      "overview":
          "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
      "popularity": 5313.091,
      "poster_path": "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
      "release_date": "2024-05-08",
      "title": "Kingdom of the Planet of the Apes",
      "video": false,
      "vote_average": 6.915,
      "vote_count": 795
    }
  ],
};
