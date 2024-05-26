import 'package:flutter_fiveflix/datasources/http_datasource.dart';

class MediaRepository {
  final HttpDatasource _datasource;

  MediaRepository({required HttpDatasource datasource})
      : _datasource = datasource;

  Future<List<T>> getListMedia<T>(
      {required String endpoint,
      required T Function(dynamic) fromJson,
      required String keyJson}) async {
    try {
      final responseApi = await _datasource.getData(url: endpoint);
      List<T> listMedias =
          responseApi[keyJson].map<T>((media) => fromJson(media)).toList();

      return listMedias;
    } catch (e) {
      rethrow;
    }
  }

  Future<T> getMediaDetail<T>(
      {required String endpoint, required T Function(dynamic) fromJson}) async {
    try {
      final responseApi = await _datasource.getData(url: endpoint);
      return fromJson(responseApi);
    } catch (e) {
      rethrow;
    }
  }
}
