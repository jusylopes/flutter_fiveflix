import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/screens/screens_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: FiveflixTheme.dark,
        home: const HomeScreen(),
      ),
    );
  }
}
