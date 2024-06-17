import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FiveflixCircularProgressIndicator extends StatelessWidget {
  const FiveflixCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      key:Key(WidgetKeys.fiveflixLoading.key),
      child: Image.asset(
        FiveflixAssetsManager.loading,
        height: 80,
      ),
    );
  }
}
