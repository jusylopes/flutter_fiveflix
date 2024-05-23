import 'package:flutter/material.dart';

class TitleMediaDetailScreen extends StatelessWidget {
  const TitleMediaDetailScreen({
    super.key,
    required this.widthScreen,
    required this.titleMedia,
  });

  final double widthScreen;
  final String titleMedia;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: SizedBox(
        width: widthScreen / 1.6,
        child: Text(
          titleMedia,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
