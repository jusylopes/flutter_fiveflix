import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class MostPopularMediaCard extends StatefulWidget {
  final String posterPath;
  final String nameMedia;
  final int mediaId;
  final double voteAverage;
  final String overview;

  const MostPopularMediaCard({
    super.key,
    required this.posterPath,
    required this.nameMedia,
    required this.mediaId,
    required this.voteAverage,
    required this.overview,
  });

  @override
  State<MostPopularMediaCard> createState() => _MostPopularMediaCardState();
}

class _MostPopularMediaCardState extends State<MostPopularMediaCard> {
  List _listFavorite = [];

  @override
  void initState() {
    super.initState();
    context.read<MediaDetailBloc>().add(
          MovieDetailFetchEvent(id: widget.mediaId),
        );

    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  void _addFavorite() {
    final favoriteItem = FavoriteModel(
      posterPath: widget.posterPath,
      id: widget.mediaId,
      title: widget.nameMedia,
      voteAverage: widget.voteAverage,
      overview: widget.overview,
    ).copyWith();

    context.read<FavoriteBloc>().add(FavoriteToggleEvent(
          item: favoriteItem,
          id: widget.mediaId,
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
                      widget.posterPath,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.nameMedia,
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
                    if (state is FavoriteGetAllSuccessState) {
                      setState(() => _listFavorite = state.items);
                    } else if (state is FavoriteItemAddedState ||
                        state is FavoriteItemRemovedState) {
                      context
                          .read<FavoriteBloc>()
                          .add(const FavoriteGetAllEvent());
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
                                FavoriteIcon(
                                  favoriteList: _listFavorite,
                                  mediaId: widget.mediaId,
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
