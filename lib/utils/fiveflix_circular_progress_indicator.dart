import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FiveflixCircularProgressIndicator extends StatelessWidget {
  const FiveflixCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        FiveflixAssetsManager.loading,
        height: 80,
      ),
    );
  }
}
