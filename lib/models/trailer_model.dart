class TrailerModel {
  final String name;
  final String key;
  final String id;

  TrailerModel({
    required this.name,
    required this.key,
    required this.id,
  });

  TrailerModel copyWith({
    String? name,
    String? key,
    String? id,
  }) =>
      TrailerModel(
        name: name ?? this.name,
        key: key ?? this.key,
        id: id ?? this.id,
      );

  factory TrailerModel.fromJson(Map<String, dynamic> json) => TrailerModel(
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
