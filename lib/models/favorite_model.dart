import 'package:hive/hive.dart';

class FavoriteModel {
  final String posterPath;
  final int id;
  final String title;
  final double voteAverage;
  final String mediaType;
  final String overview;

  FavoriteModel({
    required this.posterPath,
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.mediaType,
    required this.overview,
  });

  FavoriteModel copyWith({
    String? posterPath,
    int? id,
    String? title,
    double? voteAverage,
    String? mediaType,
    String? overview,
  }) {
    return FavoriteModel(
      posterPath: posterPath ?? this.posterPath,
      id: id ?? this.id,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      mediaType: mediaType ?? this.mediaType,
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
    final mediaType = reader.readString();
    final overview = reader.readString();
    return FavoriteModel(
      posterPath: posterPath,
      id: id,
      title: title,
      voteAverage: voteAverage,
      mediaType: mediaType,
      overview: overview,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer.writeString(obj.posterPath);
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.voteAverage);
    writer.writeString(obj.mediaType);
    writer.writeString(obj.overview);
  }
}
