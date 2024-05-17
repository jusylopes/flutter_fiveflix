import 'package:flutter_fiveflix/datasources/dio_http_datasource.dart';

class MediaRepository {
  MediaRepository(this._datasource);
  final HttpDatasource _datasource;

  Future<List<T>> getPopularListMedia<T>(
      {required endpoint, required T Function(dynamic) fromJson}) async {
    try {

      final responseApi = await _datasource.get(endpoint);
      List<T> listMedias =
          responseApi['results'].map<T>((media) => fromJson(media)).toList();

      return listMedias;
    } catch (e) {
      rethrow;
    }
  }

  Future getMediaDetail({required int id}) async {
    try {} catch (e) {
      rethrow;
    }
  }

  Future searchMedia({required String query}) async {
    try {} catch (e) {
      rethrow;
    }
  }
}
