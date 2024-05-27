import 'package:hive/hive.dart';

class FavoriteModel {
  final String posterPath;
  final int id;
  final String title;
  final double voteAverage;
  final String overview;

  FavoriteModel({
    required this.posterPath,
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.overview,
  });

  FavoriteModel copyWith({
    String? posterPath,
    int? id,
    String? title,
    double? voteAverage,
    String? overview,
  }) {
    return FavoriteModel(
      posterPath: posterPath ?? this.posterPath,
      id: id ?? this.id,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      overview: overview ?? this.overview,
    );
  }
}

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteModel read(BinaryReader reader) {
    final posterPath = reader.readString();
    final id = reader.readInt();
    final title = reader.readString();
    final voteAverage = reader.readDouble();
    final overview = reader.readString();
    return FavoriteModel(
      posterPath: posterPath,
      id: id,
      title: title,
      voteAverage: voteAverage,
      overview: overview,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer.writeString(obj.posterPath);
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.voteAverage);
    writer.writeString(obj.overview);
  }
}
