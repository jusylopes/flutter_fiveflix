import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/popular_media_screen/popular_media_bloc.dart';
import 'package:flutter_fiveflix/blocs/search_screen/search_bloc.dart';
import 'package:flutter_fiveflix/models/popular_movie_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class MediaSearch extends SearchDelegate {
  MediaSearch({
    String hintText = 'Search for movies by name...',
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        );

  final List movies = [];

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
        icon: const Icon(
          Icons.clear,
          size: 25,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 25,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<SearchBloc>(context, listen: false)
        .add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const CircularProgressIndicatorApp();
        } else if (state is SearchLoaded) {
          final List<PopularMovieModel> movies = state.mediaList;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: movies.length,
                itemBuilder: (BuildContext context, int index) {
                  final PopularMovieModel movie = movies[index];

                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaDetailScreen(
                            mediaId: movie.id,
                            mediaType: movie.mediaType,
                          ),
                        ),
                      );
                    },
                    leading: Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Image.network(
                            AppStrings.urlImagePoster + movie.posterPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const CustomSymbolApp(symbolHeight: 20.0)
                      ],
                    ),
                    title: Text(
                      movie.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      movie.popularity.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  );
                }),
          );
        } else {
          return const ErrorMessage();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<PopularMediaBloc, PopularMediaState>(
      builder: (context, state) {
        if (state is SuccessState) {
          final List<PopularMovieModel> popularMovies = state.popularMovies;
          final List<PopularMovieModel> suggestionsMovies =
              query.isEmpty ? popularMovies.take(4).toList() : [];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: suggestionsMovies.length,
              itemBuilder: (context, index) {
                final PopularMovieModel suggestion = suggestionsMovies[index];
                return ListTile(
                  onTap: () {
                    query = suggestion.title;
                    showResults(context);
                  },
                  leading: Image.network(
                    AppStrings.urlImagePoster + suggestion.posterPath,
                    height: 40,
                  ),
                  title: RichText(
                    text: TextSpan(
                        text: suggestion.title,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                );
              },
            ),
          );
        } else {
          return const CircularProgressIndicatorApp();
        }
      },
    );
  }
}
