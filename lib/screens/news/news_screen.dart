import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/news_screen/news_bloc.dart';
import 'package:flutter_fiveflix/models/enum_media_type.dart';
import 'package:flutter_fiveflix/models/media_movie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_list_tile_app.dart';
import 'package:flutter_fiveflix/utils/circular_progress_indicator_app.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin<NewsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(NewsMediaFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Now playing',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return const CircularProgressIndicatorApp();
          } else if (state is ErrorState) {
            return const ErrorLoadingMessage();
          } else if (state is NewsSuccessState) {
            final List<MediaMovieModel> newsMovies = state.newsMovies;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: newsMovies.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MediaMovieModel newsMovie = newsMovies[index];

                      return CustomListTile(
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
            return const CircularProgressIndicatorApp();
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
