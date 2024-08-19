import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/media_model.dart';
import 'package:flutter_fiveflix/screens/all_medias/all_media_type.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_media_cards.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class CategoriesMediaScreen extends StatefulWidget {
  final int categoryId;
  final String nameCategory;

  const CategoriesMediaScreen(
      {super.key, required this.categoryId, required this.nameCategory});

  @override
  State<CategoriesMediaScreen> createState() => _CategoriesMediaScreenState();
}

class _CategoriesMediaScreenState extends State<CategoriesMediaScreen> {
  late List<MediaModel> medias;

  @override
  void initState() {
    super.initState();
    medias = [];
    _fetchMedia();
  }

  @override
  void didUpdateWidget(CategoriesMediaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _fetchMedia();
    }
  }

  void _fetchMedia() {
    context
        .read<CategoriesBloc>()
        .add(MediaByCategoriesFetchEvent(idGenre: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            } else if (state is MediaByCategoriesSucessState) {
              medias = state.medias;
            }

            if (medias.isNotEmpty) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MostPopularMediaCard(
                        media: medias[0],
                        mediaType: MediaType.movie,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PopularMediaCards(
                        medias: medias,
                        titleMedia: 'Popular in ${widget.nameCategory}',
                        mediaType: AllMediaType.discoverGenre,
                        idGenre: widget.categoryId.toString(),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const FiveflixCircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
