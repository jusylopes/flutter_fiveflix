import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/search_screen/search_bloc.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/search_model.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_detail_screen.dart';
import 'package:flutter_fiveflix/screens/media_detail.dart/media_star_rating.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_symbol_app.dart';
import 'package:flutter_fiveflix/screens/widgets/recomended_medias.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/custom_empty_message.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class MediaSearch extends SearchDelegate {
  final String hintText;

  MediaSearch({
    this.hintText = 'Search for movies by name...',
  }) : super(
          searchFieldLabel: hintText,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          searchFieldStyle: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        );

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
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const RecomendedMovies();
    }
    BlocProvider.of<SearchBloc>(context, listen: false)
        .add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial || state is SearchLoading) {
          return const CircularProgressIndicatorApp();
        } else if (state is SearchSuccess) {
          final List searchList = state.mediaList;

          if (searchList.isEmpty) {
            return const CustomEmptyMessage();
          } else {
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final SearchModel movie = searchList[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MediaDetailScreen(
                                  mediaId: movie.id,
                                  mediaType: EnumMediaType.movie),
                            ),
                          );
                        },
                        leading: Stack(
                          children: [
                            SizedBox(
                              width: 120,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  AppStrings.urlImagePoster + movie.posterPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const CustomSymbolApp(symbolHeight: 20.0)
                          ],
                        ),
                        title: Text(
                          movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        subtitle:
                            CustomStarRating(voteAverage: movie.voteAverage),
                      );
                    }));
          }
        }
        return const CustomEmptyMessage();
      },
    );
  }
}
