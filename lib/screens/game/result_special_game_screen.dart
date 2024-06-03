import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/game/card_movie_special_game.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class ResultEspecialGameScreen extends StatefulWidget {
  final String selectedOption;
  const ResultEspecialGameScreen({super.key, required this.selectedOption});

  @override
  State<ResultEspecialGameScreen> createState() =>
      _ResultEspecialGameScreenState();
}

class _ResultEspecialGameScreenState extends State<ResultEspecialGameScreen> {
  late List<GenreModel> _allGenres;
  late List<GenreModel> _movieGenres;
  MediaModel? _randomMovie;

  @override
  void initState() {
    super.initState();
    _allGenres = [];
    _movieGenres = [];
    _randomMovie = null;
    context.read<CategoriesBloc>().add(const ListCategoriesFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          FiveflixAssetsManager.imageLogo,
          width: 140,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
              vertical: 15.0,
            ),
            child: SizedBox(
              width: widthScreen / 2,
              child: Column(
                children: [
                  Text(
                    FiveflixStrings.specialGameText,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '${FiveflixStrings.specialGameSubtitle}${widget.selectedOption.toLowerCase()}:',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: BlocConsumer<CategoriesBloc, CategoriesState>(
              listener: (context, state) {
                if (state is MediaCategoriesSucessState) {
                  final GenreModel categorySelected = state.genres.firstWhere(
                    (category) => category.name == widget.selectedOption,
                  );

                  _allGenres = state.genres;

                  context.read<CategoriesBloc>().add(
                      MediaByCategoriesFetchEvent(
                          idGender: categorySelected.id));
                }
              },
              builder: (context, state) {
                if (state is CategoriesLoadingState) {
                  Future.delayed(const Duration(seconds: 3));

                  return Image.asset(
                    FiveflixAssetsManager.loading,
                    height: 80,
                  );
                } else if (state is CategoriesErrorState) {
                  return ErrorLoadingMessage(
                    errorMessage: state.errorMessage,
                  );
                } else if (state is MediaByCategoriesSucessState) {
                  if (_randomMovie == null && _allGenres.isNotEmpty) {
                    final random = Random();
                    _randomMovie =
                        state.medias[random.nextInt(state.medias.length)];

                    _movieGenres = _allGenres
                        .where((genre) =>
                            _randomMovie!.genreIds.contains(genre.id))
                        .toList();
                  }
                }

                if (_randomMovie != null) {
                  return CardMovieSpecialGame(
                      heightScreen: heightScreen,
                      media: _randomMovie!,
                      movieGenres: _movieGenres);
                }
                return const FiveflixCircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
