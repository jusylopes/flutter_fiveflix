import 'package:hive/hive.dart';

abstract class FavoriteDatasource {
  Future<void> saveMedia<T>(T item);
  Future<void> deleteMedia<T>(int id);
  Future<List<T>> getAllMedias<T>();
}

class FavoriteDatasourceImpl implements FavoriteDatasource {
  @override
  Future<void> saveMedia<T>(T item) async {
    final box = await Hive.openBox<T>(T.toString());

    final key = (item as dynamic).id;
    await box.put(key, item);
  }

  @override
  Future<void> deleteMedia<T>(int id) async {
    final box = await Hive.openBox<T>(T.toString());
    await box.delete(id);
  }

  @override
  Future<List<T>> getAllMedias<T>() async {
    final box = await Hive.openBox<T>(T.toString());
    final items = box.values.toList();

    return items;
  }
}
