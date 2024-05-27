import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

abstract class HiveConfig {
  static Future<void> start() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.initFlutter(appDocumentDir.path);

    Hive.registerAdapter(FavoriteModelAdapter());
  }
}
