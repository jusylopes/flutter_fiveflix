import 'package:hive/hive.dart';

class FavoriteModel {
  final String backdropPath;
  final int id;
  final String title;
  final double voteAverage;
  final String mediaType;

  FavoriteModel(
      {required this.backdropPath,
      required this.id,
      required this.title,
      required this.voteAverage,
      required this.mediaType});

  FavoriteModel copyWith({
    String? backdropPath,
    int? id,
    String? title,
    double? voteAverage,
    String? mediaType,
  }) {
    return FavoriteModel(
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      title: title ?? this.title,
      voteAverage: voteAverage ?? this.voteAverage,
      mediaType: mediaType ?? this.mediaType,
    );
  }
}

class FavoriteModelAdapter extends TypeAdapter<FavoriteModel> {
  @override
  final int typeId = 0;

  @override
  FavoriteModel read(BinaryReader reader) {
    final backdropPath = reader.readString();
    final id = reader.readInt();
    final title = reader.readString();
    final voteAverage = reader.readDouble();
    final mediaType = reader.readString();
    return FavoriteModel(
      backdropPath: backdropPath,
      id: id,
      title: title,
      voteAverage: voteAverage,
      mediaType: mediaType,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteModel obj) {
    writer.writeString(obj.backdropPath);
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.voteAverage);
    writer.writeString(obj.mediaType);
  }
}
