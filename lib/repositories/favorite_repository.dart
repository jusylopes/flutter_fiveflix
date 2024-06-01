import 'package:flutter_fiveflix/datasources/favorite_datasource.dart';

class FavoriteRepository {
  final FavoriteDatasource _datasource;

  FavoriteRepository({required FavoriteDatasource datasource})
      : _datasource = datasource;

  Future<void> saveMedia<T>(T item) => _datasource.saveMedia(item);
  Future<void> deleteMedia<T>(int id) => _datasource.deleteMedia(id);
  Future<List<T>> getAllMedias<T>() => _datasource.getAllMedias<T>();
}
