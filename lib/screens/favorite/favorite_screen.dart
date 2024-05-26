import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/favorite_model.dart';
import 'package:flutter_fiveflix/screens/widgets/media_list_item.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(const FavoriteGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'My list favorite',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteInitialState || state is FavoriteLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is FavoriteErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.message,
            );
          } else if (state is FavoriteGetAllSuccessState) {
            final List favoriteList = state.items;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favoriteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final FavoriteModel itemFavorite = favoriteList[index];

                      //return Text(itemFavorite.title);

                      return MediaListItem(
                        titleMedia: itemFavorite.title,
                        idMedia: itemFavorite.id,
                        posterPathMedia: itemFavorite.backdropPath,
                        mediaType: itemFavorite.mediaType == 'movie'
                            ? EnumMediaType.movie
                            : EnumMediaType.serie,
                        voteAverage: itemFavorite.voteAverage,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const FiveflixCircularProgressIndicator();
          }
        },
      ),
    );
  }
}
