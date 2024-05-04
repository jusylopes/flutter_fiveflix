import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_bloc.dart';
import 'package:flutter_fiveflix/blocs/movies/popular/popular_state.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/movie_detail/most_popular_movie_card.dart';
import 'package:flutter_fiveflix/screens/widgets/card_movie.dart';
import 'package:flutter_fiveflix/utils/assets_manager.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final List<PopularMovieModel> popularMovies = [];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.imageLogo,
          width: 140,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: BlocConsumer<PopularMovieBloc, PopularMovieState>(
        listener: (context, state) {
          if (state is LoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  ('Loading movies...'),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is InitialState ||
              state is LoadingState && popularMovies.isEmpty) {
            return const CircularProgressIndicatorApp();
          } else if (state is ErrorState) {
            return const ErrorMessage();
          } else if (state is SuccessState) {
            popularMovies.addAll(state.popularMovies);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MostPopularMovieCard(
                popularMovies: popularMovies,
                screenHeight: screenHeight,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Popular Movies',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: popularMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final movie = popularMovies[index];

                    return CardMedia(
                      mediaTitle: movie.originalTitle,
                      posterPath: movie.posterPath,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'My list',
          ),
        ],
      ),
    );
  }
}
