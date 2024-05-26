import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/screens/widgets/media_list_item.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MediaBloc>().add(NewsFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Now playing',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          if (state is MediaInitialState || state is MediaLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is MediaErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is NewsSuccessState) {
            final List<MovieModel> newsMovies = state.newsMovies;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: newsMovies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MovieModel newsMovie = newsMovies[index];

                      return MediaListItem(
                        titleMedia: newsMovie.title,
                        idMedia: newsMovie.id,
                        posterPathMedia: newsMovie.backdropPath,
                        mediaType: EnumMediaType.movie,
                        voteAverage: newsMovie.voteAverage,
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
