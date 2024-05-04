import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/models/movie_detail_model.dart';


class MovieDetailHeaderImage extends StatelessWidget {
  const MovieDetailHeaderImage({super.key, required this.movie});

  final MovieDetailModel movie;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();

    /// IMPLEMENTAR TOPO DA TELA DE MOVIE DETAIL
    ///usar a variavel _movie p acessar os detalhes sobre o filme
    /////exemplo

    /// Text(
    ///   'Esse é o nome do filme ${_movie.title}',
    ///   style: Theme.of(context).textTheme.titleLarge,
    /// )
  }
}
