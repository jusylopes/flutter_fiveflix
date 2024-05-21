import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs.dart';
import 'package:flutter_fiveflix/screens/home/home_screen.dart';
import 'package:flutter_fiveflix/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const HomeScreen(),
      ),
    );
  }
}
