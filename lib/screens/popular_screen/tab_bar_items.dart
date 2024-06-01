import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class TabBarItems extends StatelessWidget {
  final TabController tabController;
  const TabBarItems({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 45,
        color: FiveflixColors.backgroundColor,
        child: TabBar(
          controller: tabController,
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
                _showCategoriesModal(context);
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
                      width: 8.0,
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
    );
  }

  void _showCategoriesModal(BuildContext context) {
    context
        .read<MediaBloc>()
        .add(const MediaDetailFetchEvent(id: 500, mediaType: 'movie'));

    List<GenreModel> genres = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: double.infinity,
          color: Colors.black.withOpacity(0.7),
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<MediaBloc, MediaState>(
                builder: (context, state) {
                  if (state is MediaLoadingState) {
                    return const FiveflixCircularProgressIndicator();
                  } else if (state is MediaErrorState) {
                    return ErrorLoadingMessage(
                      errorMessage: state.errorMessage,
                    );
                  } else if (state is MediaDetailSucessState) {
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
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
              ),
            ],
          ),
        );
      },
    );
  }
}