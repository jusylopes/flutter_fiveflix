import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/media_detail_screen/media_detail_bloc.dart';
import 'package:flutter_fiveflix/screens/widgets/media_chip_genre.dart';
import 'package:flutter_fiveflix/screens/widgets/transparent_gradient_container.dart';
import 'package:flutter_fiveflix/utils/colors.dart';
import 'package:flutter_fiveflix/utils/strings.dart';

class MostPopularMovieCard extends StatefulWidget {
  const MostPopularMovieCard({
    super.key,
    required this.posterPathMovie,
    required this.nameMovie,
    required this.movieId,
  });

  final String posterPathMovie;
  final String nameMovie;
  final int movieId;

  @override
  State<MostPopularMovieCard> createState() => _MostPopularMovieCardState();
}

class _MostPopularMovieCardState extends State<MostPopularMovieCard> {
  @override
  void initState() {
    super.initState();
    context.read<MediaDetailBloc>().add(
          MovieDetailFetchEvent(id: widget.movieId),
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            TransparentGradientContainer(
              height: screenHeight / 2.4,
              child: Container(
                color: AppColors.backgroundColor,
                child: Image.network(
                  AppStrings.urlImagePosterOriginal + widget.posterPathMovie,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  color: const Color.fromRGBO(255, 255, 255, 0.8),
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    widget.nameMovie,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                BlocBuilder<MediaDetailBloc, MediaDetailState>(
                  builder: (context, state) {
                    if (state is MovieDetailSuccessState) {
                      return MediaChipGenre(
                          genresMovie: state.movie.genres,
                          wrapAlignment: WrapAlignment.center);
                    }
                    return const SizedBox.shrink();
                  },
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Chip(
                        label: Row(
                          children: [
                            Text(
                              'My list',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        backgroundColor: AppColors.primaryColor,
                        side: const BorderSide(
                          width: 0,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            )
          ],
        ),
      ),
    );
  }
}
