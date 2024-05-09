import 'package:flutter_fiveflix/models/media_type.dart';

class PopularSerieModel {
  final String? backdropPath;
  final int id;
  final String originalName;
  final double popularity;
  final String posterPath;
  final String name;
  final MediaType mediaType;

  PopularSerieModel({
    this.backdropPath,
    required this.id,
    required this.originalName,
    required this.popularity,
    required this.posterPath,
    required this.name,
    this.mediaType = MediaType.serie,
  });
}
