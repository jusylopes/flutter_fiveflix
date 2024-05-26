import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class SnackBarHelper {
  static void showSnackBar({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: FiveflixColors.primaryColor,
        content: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}