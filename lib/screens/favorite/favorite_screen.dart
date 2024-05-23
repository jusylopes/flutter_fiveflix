import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My list favorite',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const Placeholder(),
    );
  }
}
