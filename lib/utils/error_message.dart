import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class ErrorLoadingMessage extends StatelessWidget {
  const ErrorLoadingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.errorLoadingMessage,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
