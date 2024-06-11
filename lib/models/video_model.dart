class VideoModel {
  final String name;
  final String key;
  final String id;

  VideoModel({
    required this.name,
    required this.key,
    required this.id,
  });

  VideoModel copyWith({
    String? name,
    String? key,
    String? id,
  }) =>
      VideoModel(
        name: name ?? this.name,
        key: key ?? this.key,
        id: id ?? this.id,
      );

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        name: json["name"],
        key: json["key"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "key": key,
        "id": id,
      };
}
