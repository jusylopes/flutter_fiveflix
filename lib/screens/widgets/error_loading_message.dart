import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class ErrorLoadingMessage extends StatelessWidget {
  const ErrorLoadingMessage({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    final double sizeWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FiveflixAnimatedIcon(sizeIcon: 150),
          Container(
            padding: const EdgeInsets.only(bottom: 15),
            width: sizeWidth / 1.5,
            child: Text(
              FiveflixStrings.errorMessage,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: sizeWidth / 1.5,
            child: Text(
              errorMessage,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
