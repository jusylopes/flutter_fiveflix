import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.emptyMediaMessage,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
