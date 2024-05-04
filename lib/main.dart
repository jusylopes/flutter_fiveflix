import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_event.dart';
import 'package:flutter_fiveflix/blocs/series/popular/popular_bloc.dart';
import 'package:flutter_fiveflix/blocs/series/popular/popular_event.dart';
import 'package:flutter_fiveflix/blocs/series/serie_detail/serie_detail_bloc.dart';
import 'package:flutter_fiveflix/repositories/media_repository.dart';

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
          create: (_) => MovieDetailBloc(
            repository: MediaRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => PopularMovieBloc(
            repository: MediaRepository(),
          )..add(PopularMovieFetchEvent()),
        ),
        BlocProvider(
          create: (_) => SerieDetailBloc(
            repository: MediaRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => PopularSerieBloc(
            repository: MediaRepository(),
          )..add(PopularSerieFetchEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: AppTheme.dark,
        //home: const HomeScreen(),
      ),
    );
  }
}
