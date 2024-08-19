import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/blocs_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';
import 'package:flutter_fiveflix/screens/all_medias/all_media_type.dart';
import 'package:flutter_fiveflix/screens/all_medias/grid_view_all_media.dart';
import 'package:flutter_fiveflix/screens/widgets/custom_app_bar.dart';
import 'package:flutter_fiveflix/screens/widgets/widgets_exports.dart';

class AllMediaScreen extends StatefulWidget {
  final AllMediaType mediaType;
  final String titleMedia;
  final String idGenre;

  const AllMediaScreen(
      {super.key,
      required this.mediaType,
      required this.titleMedia,
      this.idGenre = ''});

  @override
  State<AllMediaScreen> createState() => _AllMediaScreenState();
}

class _AllMediaScreenState extends State<AllMediaScreen> {
  List<MediaModel> allMedias = [];
  final ScrollController _scrollController = ScrollController();
  late AllMediaBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read<AllMediaBloc>();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.currentPage = 1;
      bloc.add(AllMediaFetchEvent(
          mediaType: widget.mediaType, idGenre: widget.idGenre));
      _fetchMediaOnScroll();
    });
  }

  @override
  void dispose() {
    bloc.add(ResetAllMediaEvent());
    super.dispose();
  }

  void _fetchMediaOnScroll() {
    _scrollController.addListener(() {
      final double scrollPosition = _scrollController.offset;
      final double maxScrollExtent = _scrollController.position.maxScrollExtent;
      final double threshold = maxScrollExtent * 0.7;

      if (scrollPosition >= threshold &&
          !BlocProvider.of<AllMediaBloc>(context).isFetching) {
        BlocProvider.of<AllMediaBloc>(context)
          ..isFetching = true
          ..add(AllMediaFetchEvent(
            mediaType: widget.mediaType,
            idGenre: widget.idGenre,
          ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              widget.titleMedia,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        body: BlocBuilder<AllMediaBloc, AllMediaState>(
          builder: (context, state) {
            if (state is MediaLoadingState) {
              return const FiveflixCircularProgressIndicator();
            } else if (state is AllMediaErrorState) {
              return ErrorLoadingMessage(
                errorMessage: state.errorMessage,
              );
            } else if (state is AllMediaSuccessState) {
              if (BlocProvider.of<AllMediaBloc>(context).currentPage == 1) {
                allMedias = state.allMedias;
              } else {
                final newItems = state.allMedias
                    .where(
                      (media) => !allMedias
                          .any((existingMedia) => existingMedia.id == media.id),
                    )
                    .toList();

                allMedias.addAll(newItems);
              }
            }

            if (allMedias.isNotEmpty) {
              return GridViewAllMedia(
                  allMedia: allMedias,
                  scrollController: _scrollController,
                  screenWidth: screenWidth);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
