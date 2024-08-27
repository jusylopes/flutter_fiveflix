import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/media_detail/widgets/media_detail_widgets_exports.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class MediaDetailBody extends StatefulWidget {
  final MediaModel media;
  final MediaType mediaType;

  const MediaDetailBody({
    super.key,
    required this.media,
    required this.mediaType,
  });

  @override
  State<MediaDetailBody> createState() => _MediaDetailBodyState();
}

class _MediaDetailBodyState extends State<MediaDetailBody> {
  @override
  void initState() {
    super.initState();
    context.read<MediaBloc>().add(MediaDetailFetchEvent(
          id: widget.media.id,
          mediaType: widget.mediaType == MediaType.movie ? 'movie' : 'tv',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleMediaDetailScreen(
                  widthScreen: widthScreen,
                  titleMedia: widget.media.isMovie
                      ? widget.media.title!
                      : widget.media.name!,
                ),
                SizedBox(
                  width: widthScreen / 1.3,
                  child: MediaChipGenre(
                    idMedia: widget.media.id,
                    idGenre: widget.media.genreIds,
                    wrapAlignment: WrapAlignment.start,
                    mediaType: widget.mediaType,
                  ),
                ),
                MediaDetailRow(
                  voteAverage: widget.media.voteAverage,
                  releaseDate: widget.mediaType == MediaType.movie
                      ? widget.media.releaseDate!
                      : widget.media.firstAirDate!,
                ),
                StoryLineWidget(mediaOverview: widget.media.overview),
                BlocBuilder<MediaBloc, MediaState>(
                  builder: (context, state) {
                    if (state is MediaLoadingState) {
                      return const Center(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 65),
                            child: FiveflixCircularProgressIndicator()),
                      );
                    } else if (state is MediaDetailSucessState) {
                      List<CastModel> casts = state.casts;
                      List<VideoModel> videos = state.trailers;

                      return Column(
                        children: [
                          VideoWidget(
                            videoList: videos,
                          ),
                          CastWidget(
                            castList: casts,
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
            FavoriteButton(itemFavorite: widget.media),
          ],
        ));
  }
}
