import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/blocs/bloc_exports.dart';
import 'package:flutter_fiveflix/models/models_exports.dart';

class MediaChipGenre extends StatefulWidget {
  final WrapAlignment wrapAlignment;
  final MediaType mediaType;
  final List<int> idGenre;
  final int idMedia;

  const MediaChipGenre({
    super.key,
    required this.wrapAlignment,
    required this.mediaType,
    required this.idGenre,
    required this.idMedia,
  });

  @override
  State<MediaChipGenre> createState() => _MediaChipGenreState();
}

class _MediaChipGenreState extends State<MediaChipGenre> {
  @override
  void initState() {
    super.initState();

    context.read<CategoriesBloc>().add(MediaCategoriesFetchEvent(
          id: widget.idMedia,
          mediaType: widget.mediaType == MediaType.movie ? 'movie' : 'tv',
        ));
  }

  List<GenreModel> _containsGenres(
      List<GenreModel> allGenres, List<int> genreIds) {
    return allGenres.where((genre) => genreIds.contains(genre.id)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is MediaCategoriesSucessState) {
          List<GenreModel> movieGenres = _containsGenres(
            state.genres,
            widget.idGenre,
          );

          return Wrap(
            alignment: widget.wrapAlignment,
            spacing: 20,
            children: movieGenres.map((genre) {
              return Text(
                genre.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              );
            }).toList(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
