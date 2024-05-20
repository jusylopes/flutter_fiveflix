class CastModel {
  final int id;
  final String name;
  final String? profilePath;

  CastModel({
    required this.id,
    required this.name,
    required this.profilePath,
  });

  CastModel copyWith({
    int? id,
    String? name,
    String? profilePath,
  }) =>
      CastModel(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePath: profilePath ?? this.profilePath,
      );

  factory CastModel.fromJson(Map<String, dynamic> json) => CastModel(
        id: json["id"],
        name: json["name"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_path": profilePath,
      };
}
