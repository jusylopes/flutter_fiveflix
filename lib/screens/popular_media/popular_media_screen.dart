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
                GestureDetector(
                  onTap: () {
                    showCategoriesModal(context);
                  },
                  child: Tab(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Categories',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                          child: Icon(
                            Icons.expand_more,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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

  void showCategoriesModal(BuildContext context) {
    context
        .read<CategoriesBloc>()
        .add(const CategoriesFetchEvent(id: 500, mediaType: 'movie'));

    List<GenreModel> genres = []; // criando a lista
    // cria o metodo e passa o context
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity, // tomar a a tela inteira
          color: Colors.black.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoadingState) {
                    return const FiveflixCircularProgressIndicator();
                  } else if (state is CategoriesErrorState) {
                    return ErrorLoadingMessage(
                      errorMessage: state.errorMessage,
                    );
                  } else if (state is CategoriesSucessState) {
                    genres = state.genres;
                  }

                  if (genres.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: genres.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: ListTile(
                                title: Text(
                                  genres[index].name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {},
                              ),
                            );
                          }),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: FiveflixColors.primaryColor,
                    shape: const CircleBorder(),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
