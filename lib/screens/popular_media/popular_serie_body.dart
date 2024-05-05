import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fiveflix/blocs/series/popular/popular_bloc.dart';
import 'package:flutter_fiveflix/blocs/series/popular/popular_state.dart';
import 'package:flutter_fiveflix/models/popular_serie_model.dart';
import 'package:flutter_fiveflix/screens/widgets/card_movie.dart';
import 'package:flutter_fiveflix/utils/error_message.dart';

class PopularSeriebody extends StatelessWidget {
  const PopularSeriebody({
    super.key,
    required this.popularSeries,
  });

  final List<PopularSerieModel> popularSeries;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularSerieBloc, PopularSerieState>(
      builder: (context, state) {
        if (state is InitialState ||
            (state is LoadingState && popularSeries.isEmpty)) {
          return const Center();
        } else if (state is ErrorState) {
          return const ErrorMessage();
        } else if (state is SuccessState) {
          popularSeries.addAll(state.popularSeries);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Popular Series',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 200,
              child: ListView.builder(
                itemCount: popularSeries.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = popularSeries[index];

                  return CardMedia(
                    mediaTitle: movie.originalName,
                    posterPath: movie.posterPath,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
