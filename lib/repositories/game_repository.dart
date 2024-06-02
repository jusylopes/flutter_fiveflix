import 'package:flutter_fiveflix/datasources/http_datasource.dart';

class GameRepository {
  final HttpDatasource _datasource;
  
  GameRepository({required HttpDatasource datasource}) : _datasource = datasource;

  Future<List<T>> getListGame<T>({
    required String endpoint,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final responseApi = await _datasource.getData(url: endpoint);
      List<T> listGames = (responseApi.data as List).map<T>((gamedata) {
        return fromJson(gamedata);
      }).toList();
      return listGames;
    } catch (e) {
      rethrow;
    }
  }
}
