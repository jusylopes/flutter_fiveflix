import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class SearchScreen extends SearchDelegate {
  final String hintText;

  SearchScreen({
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
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: Theme.of(context).textTheme.titleSmall),
    );
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

  @override
  void showSuggestions(BuildContext context) {
    _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const MediaRecomended();
    }
    BlocProvider.of<SearchBloc>(context, listen: false)
        .add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial || state is SearchLoading) {
          return const FiveflixCircularProgressIndicator();
        } else if (state is SearchSuccess) {
          final List<SearchModel> searchList = state.searchResult;

          if (searchList.isEmpty) {
            return const CustomEmptyMessageSearch();
          } else {
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final SearchModel movie = searchList[index];

                      return MediaListItem(
                          titleMedia: movie.title,
                          idMedia: movie.id,
                          posterPathMedia: movie.posterPath,
                          mediaType: EnumMediaType.movie,
                          voteAverage: movie.voteAverage);
                    }));
          }
        }
        return const CustomEmptyMessageSearch();
      },
    );
  }
}
