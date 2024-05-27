import 'package:flutter_fiveflix/datasources/local_datasource.dart';

class LocalMediaRepository {
  final LocalDatasource _datasource;

  LocalMediaRepository({required LocalDatasource datasource})
      : _datasource = datasource;

  Future<void> saveMedia<T>(T item) => _datasource.saveMedia(item);
  Future<void> deleteMedia<T>(int id) => _datasource.deleteMedia(id);
  Future<List<T>> getAllMedias<T>() => _datasource.getAllMedias<T>();
}
