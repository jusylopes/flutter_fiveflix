import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class MostPopularMediaCard extends StatefulWidget {
  final MediaModel media;
  final MediaType mediaType;

  const MostPopularMediaCard(
      {super.key, required this.media, required this.mediaType});

  @override
  State<MostPopularMediaCard> createState() => _MostPopularMediaCardState();
}

class _MostPopularMediaCardState extends State<MostPopularMediaCard> {
  List _listFavorite = [];

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  void _addFavorite() {
    context.read<FavoriteBloc>().add(FavoriteToggleEvent(
          item: widget.media,
          id: widget.media.id,
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
                      widget.media.posterPath,
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: screenHeight / 3,
                  child: Text(
                    widget.media.isMovie
                        ? widget.media.title!
                        : widget.media.name!,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.asset(
                        FiveflixAssetsManager.top10,
                        width: 25.0,
                        height: 25.0,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Top 1 on today\'s ${widget.mediaType == MediaType.movie ? 'movie' : 'serie'} list',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                                  mediaId: widget.media.id,
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
