import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class TabBarItems extends StatefulWidget {
  final TabController tabController;
  final Function(int, String) onCategorySelected;

  const TabBarItems({
    super.key,
    required this.tabController,
    required this.onCategorySelected,
  });

  @override
  State<TabBarItems> createState() => _TabBarItemsState();
}

class _TabBarItemsState extends State<TabBarItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: FiveflixColors.backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TabBar(
        controller: widget.tabController,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.all(7.0),
        unselectedLabelStyle:
            const TextStyle(color: FiveflixColors.primaryColor),
        unselectedLabelColor: FiveflixColors.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
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
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: 200,
              child: Tab(
                child: Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showCategoriesModal(BuildContext context) {
    context.read<CategoriesBloc>().add(const ListCategoriesFetchEvent());
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
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoadingState) {
                    return const FiveflixCircularProgressIndicator();
                  } else if (state is CategoriesErrorState) {
                    return ErrorLoadingMessage(
                      errorMessage: state.errorMessage,
                    );
                  } else if (state is MediaCategoriesSucessState) {
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
                                onTap: () {
                                  int selectedCategoryId = genres[index].id;
                                  String selectedNameCategory =
                                      genres[index].name;
                                  widget.onCategorySelected(
                                    selectedCategoryId,
                                    selectedNameCategory,
                                  );

                                  Navigator.pop(context);
                                },
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
