import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_movie_cards.dart';
import 'package:flutter_fiveflix/screens/popular_media/popular_serie_cards.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class PopularMediaScreen extends StatefulWidget {
  const PopularMediaScreen({super.key});

  @override
  State<PopularMediaScreen> createState() => _PopularMediaScreenState();
}

class _PopularMediaScreenState extends State<PopularMediaScreen>
    with SingleTickerProviderStateMixin {
  List<MediaModel> popularMovies = [];
  List<MediaModel> popularSeries = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<MediaBloc>().add(PopularMediaFetchEvent());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 45, 
            color: FiveflixColors.backgroundColor,
            child: TabBar( 
              controller: _tabController,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(10.0),
              unselectedLabelStyle: 
                  const TextStyle(color: FiveflixColors.primaryColor),
              unselectedLabelColor: FiveflixColors.primaryColor, 
              indicatorSize: TabBarIndicatorSize.tab, 
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: FiveflixColors.primaryColor,
              ),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  child: Text(
                    'Movies',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Tab(
                  child: Text(
                    'Series',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Categories',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      const Icon(
                        Icons.expand_more,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BlocBuilder<MediaBloc, MediaState>(
                builder: (context, state) {
                  if (state is MediaInitialState ||
                      state is MediaLoadingState) {
                    return const FiveflixCircularProgressIndicator();
                  } else if (state is MediaErrorState) {
                    return ErrorLoadingMessage(
                      errorMessage: state.errorMessage,
                    );
                  } else if (state is PopularSuccessState) {
                    popularMovies = state.popularMovies;
                    popularSeries = state.popularSeries;
                  }

                  if (popularMovies.isNotEmpty && popularSeries.isNotEmpty) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            MostPopularMediaCard(
                              media: popularMovies[0],
                              mediaType: MediaType.movie,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            PopularMediaCards(
                              popularMovies: popularMovies,
                            ),
                          ],
                        ),
                        PopularSerieCards(popularSeries: popularSeries),
                      ],
                    );
                  }

                  return const FiveflixCircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}