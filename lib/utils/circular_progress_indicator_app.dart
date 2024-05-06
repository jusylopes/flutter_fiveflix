import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/assets_manager.dart';


class CircularProgressIndicatorApp extends StatelessWidget {
  const CircularProgressIndicatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AssetsManager.loading,
        height: 80,
      ),
    );
  }
}
