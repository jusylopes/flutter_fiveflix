import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_movie_body.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_serie_body.dart';

class PopularMediaScreen extends StatelessWidget {
  const PopularMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final List<PopularMovieModel> popularMovies = [];
    final List<PopularSerieModel> popularSeries = [];

    return SingleChildScrollView(
      child: Column(
        children: [
          PopularMoviebody(
            popularMovies: popularMovies,
            screenHeight: screenHeight,
          ),
          PopularSeriebody(popularSeries: popularSeries)
        ],
      ),
    );
  }
}
