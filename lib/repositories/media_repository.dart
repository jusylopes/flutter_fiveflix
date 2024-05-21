import 'package:flutter_fiveflix/datasources/dio_http_datasource.dart';

class MediaRepository {
  MediaRepository(this._datasource);
  final HttpDatasource _datasource;

  Future<List<T>> getListMedia<T>(
      {required String endpoint,
      required T Function(dynamic) fromJson,
      required String keyJson}) async {
    try {
      final responseApi = await _datasource.get(url: endpoint);
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
      final responseApi = await _datasource.get(url: endpoint);
      return fromJson(responseApi);
    } catch (e) {
      rethrow;
    }
  }
}
