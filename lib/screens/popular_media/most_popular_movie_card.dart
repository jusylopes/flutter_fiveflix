import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class MostPopularMovieCard extends StatefulWidget {
  final String posterPathMovie;
  final String nameMovie;
  final int movieId;
  final double voteAverage;
  final String overview;

  const MostPopularMovieCard({
    super.key,
    required this.posterPathMovie,
    required this.nameMovie,
    required this.movieId,
    required this.voteAverage,
    required this.overview,
  });

  @override
  State<MostPopularMovieCard> createState() => _MostPopularMovieCardState();
}

class _MostPopularMovieCardState extends State<MostPopularMovieCard> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<MediaDetailBloc>().add(
          MovieDetailFetchEvent(id: widget.movieId),
        );
    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  void _addFavorite() {
    final favoriteItem = FavoriteModel(
      posterPath: widget.posterPathMovie,
      id: widget.movieId,
      title: widget.nameMovie,
      voteAverage: widget.voteAverage,
      overview: widget.overview,
    ).copyWith();

    context.read<FavoriteBloc>().add(FavoriteToggleEvent(
          item: favoriteItem,
          id: widget.movieId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            TransparentGradientContainer(
              height: screenHeight / 2.4,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
                child: CachedNetworkImageMedia(
                  url: FiveflixStrings.urlImagePosterOriginal +
                      widget.posterPathMovie,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.nameMovie,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                BlocBuilder<MediaDetailBloc, MediaDetailState>(
                  builder: (context, state) {
                    if (state is MovieDetailSuccessState) {
                      return MediaChipGenre(
                          genresMovie: state.movie.genres,
                          wrapAlignment: WrapAlignment.center);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(
                  height: 5.0,
                ),
                BlocConsumer<FavoriteBloc, FavoriteState>(
                  listener: (context, state) {
                    if (state is FavoriteItemAddedState) {
                      if (state.item.id == widget.movieId) {
                        setState(() => _isFavorite = true);
                      }
                      SnackBarHelper.showSnackBar(
                        context: context,
                        text: FiveflixStrings.addToFavoritesSuccessMessage,
                      );
                    } else if (state is FavoriteItemRemovedState) {
                      setState(() => _isFavorite = false);

                      SnackBarHelper.showSnackBar(
                        context: context,
                        text: FiveflixStrings.removeFromFavoritesSuccessMessage,
                      );
                    } else if (state is FavoriteErrorState) {
                      SnackBarHelper.showSnackBar(
                        context: context,
                        text: FiveflixStrings.errorMessage,
                      );
                    } else if (state is FavoriteGetAllSuccessState) {
                      setState(() => _isFavorite =
                          state.items.any((item) => item.id == widget.movieId));
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: _addFavorite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Chip(
                            label: Row(
                              children: [
                                Text('My list',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                                const SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  _isFavorite ? Icons.check : Icons.add,
                                ),
                              ],
                            ),
                            backgroundColor: FiveflixColors.primaryColor,
                            side: const BorderSide(
                              width: 0,
                              color: FiveflixColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 25),
              ],
            )
          ],
        ),
      ),
    );
  }
}
