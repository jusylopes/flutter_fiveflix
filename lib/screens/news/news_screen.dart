import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<MediaModel> newsMovies = [];

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
          if (state is MediaLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is MediaErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is NewsSuccessState) {
            newsMovies = state.newsMovies;
          }

          if (newsMovies.isNotEmpty) {
            return MediaGridView(
              mediaList: newsMovies,
              mediaType: MediaType.movie,
            );
          }
          return const FiveflixCircularProgressIndicator();
        },
      ),
    );
  }
}
