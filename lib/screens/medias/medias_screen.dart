import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/medias/medias_cards.dart';
import 'package:flutter_fiveflix/screens/medias/tab_bar_items.dart';
import 'package:flutter_fiveflix/screens/widgets/error_loading_message.dart';
import 'package:flutter_fiveflix/screens/widgets/fiveflix_circular_progress_indicator.dart';
import 'package:flutter_fiveflix/screens/widgets/most_popular_media_card.dart';

class MediasScreen extends StatefulWidget {
  const MediasScreen({super.key});

  @override
  State<MediasScreen> createState() => _MediasScreenState();
}

class _MediasScreenState extends State<MediasScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<MediaModel> popularMovies;
  late List<MediaModel> popularSeries;
  late List<GenreModel> categories;

  @override
  void initState() {
    super.initState();
    popularMovies = [];
    popularSeries = [];
    categories = [];

    _tabController = TabController(length: 2, vsync: this);
    context.read<MediaBloc>().add(PopularMediaFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBarItems(tabController: _tabController),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMoviesPage(),
                _buildSeriesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesPage() {
    return SingleChildScrollView(
      child: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          if (state is MediaInitialState || state is MediaLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is MediaErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is PopularSuccessState) {
            popularMovies = state.popularMovies;

            return Column(children: [
              MostPopularMediaCard(
                media: popularMovies[0],
                mediaType: MediaType.movie,
              ),
              const SizedBox(
                height: 20,
              ),
              PopularMediaCards(
                medias: popularMovies,
                titleMedia: 'Movies',
              )
            ]);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSeriesPage() {
    return SingleChildScrollView(
      child: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          if (state is MediaInitialState || state is MediaLoadingState) {
            return const FiveflixCircularProgressIndicator();
          } else if (state is MediaErrorState) {
            return ErrorLoadingMessage(
              errorMessage: state.errorMessage,
            );
          } else if (state is PopularSuccessState) {
            popularSeries = state.popularSeries;

            return Column(children: [
              MostPopularMediaCard(
                media: popularSeries[0],
                mediaType: MediaType.movie,
              ),
              const SizedBox(
                height: 20,
              ),
              PopularMediaCards(
                medias: popularSeries,
                titleMedia: 'Series',
              )
            ]);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
