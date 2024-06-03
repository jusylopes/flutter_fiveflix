import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart'as path_provider;

abstract class HiveConfig {
  static Future<void> start() async {
    final dbDir = await path_provider.getApplicationDocumentsDirectory();
     await Hive.initFlutter(dbDir.path);
     await Hive.openBox('tmdb');

    Hive.registerAdapter(MediaModelAdapter());
  }
}
