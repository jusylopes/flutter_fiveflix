import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:hive_flutter/adapters.dart';

abstract class HiveConfig {
  static Future<void> start() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MediaModelAdapter());
    await Hive.openBox('tmdb');
  }
}
