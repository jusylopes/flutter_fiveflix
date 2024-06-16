import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/popular_screen/widgets/popular_media_cards.dart';
import 'package:flutter_fiveflix/screens/widgets/error_loading_message.dart';
import 'package:flutter_fiveflix/screens/widgets/fiveflix_circular_progress_indicator.dart';
import 'package:flutter_fiveflix/screens/widgets/most_popular_media_card.dart';

class PopularSerieScreen extends StatefulWidget {
  const PopularSerieScreen({super.key});

  @override
  State<PopularSerieScreen> createState() => _PopularSerieScreenState();
}

class _PopularSerieScreenState extends State<PopularSerieScreen> {
  late List<MediaModel> medias;
  late List<MediaModel> seriesTopRated;

  @override
  void initState() {
    super.initState();
    medias = [];
    seriesTopRated = [];

    context.read<MediaBloc>().add(PopularSerieFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<MediaBloc, MediaState>(
          builder: (context, state) {
            if (state is MediaInitialState || state is MediaLoadingState) {
              return const FiveflixCircularProgressIndicator();
            } else if (state is MediaErrorState) {
              return ErrorLoadingMessage(
                errorMessage: state.errorMessage,
              );
            } else if (state is PopularSerieSuccessState) {
              medias = state.popularMedias;
              seriesTopRated = state.topRatedTv;
            }

            if (medias.isNotEmpty && seriesTopRated.isNotEmpty) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    MostPopularMediaCard(
                      media: medias[0],
                      mediaType: MediaType.serie,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PopularMediaCards(
                      medias: medias,
                      titleMedia: 'Series',
                    ),
                    PopularMediaCards(
                      medias: seriesTopRated,
                      titleMedia: 'Top Rated Series',
                    )
                  ]),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
