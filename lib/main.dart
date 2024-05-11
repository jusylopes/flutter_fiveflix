import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/media_detail_screen/media_detail_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_bloc.dart';
import 'package:flutter_fiveflix/blocs/search_screen/search_bloc.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';
import 'package:flutter_fiveflix/screens/home/home_screen.dart';
import 'package:flutter_fiveflix/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMediaBloc(
            repository: MediaRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => MediaDetailBloc(
            repository: MediaRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => SearchBloc(
            repository: MediaRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        home: const HomeScreen(),
      ),
    );
  }
}
