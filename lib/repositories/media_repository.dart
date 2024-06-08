import 'package:flutter_fiveflix/datasources/http_datasource.dart';
import 'package:flutter_fiveflix/datasources/local_datasource.dart';
import 'package:flutter_fiveflix/repositories/check_internet_use_case.dart';

class MediaRepository {
  final HttpDatasource _datasource;
  final LocalDatasource _localDatasource;
  final CheckInternetUsecase _checkInternetUsecase;

  MediaRepository(
      {required HttpDatasource datasource,
      required LocalDatasource localDatasource,
      required CheckInternetUsecase checkInternetUsecase})
      : _datasource = datasource,
        _localDatasource = localDatasource,
        _checkInternetUsecase = checkInternetUsecase;

  Future<List<T>> getListMedia<T>(
      {required String endpoint,
      required T Function(dynamic) fromJson,
      required String keyJson}) async {
    final hasConnectivity = await _checkInternetUsecase.call();
    List<T> listMedias = [];

    try {
      if (hasConnectivity) {
        final responseApi = await _datasource.getData(url: endpoint);
        listMedias = (responseApi[keyJson] as List)
            .map<T>((media) => fromJson(media))
            .toList();

        await _localDatasource.set(endpoint, responseApi);
        return listMedias;
      } else {
        final localData = await _localDatasource.get(endpoint);
        if (localData != null) {
          listMedias = (localData[keyJson] as List)
              .map<T>((media) => fromJson(media))
              .toList();
        }
        return listMedias;
      }
    } catch (e) {
      [];
      rethrow;
    }
  }
}
