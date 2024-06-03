class GameModel {
    final String nameGame;
    final String posterPath;
    final List<Question> questions;

    GameModel({
        required this.nameGame,
        required this.posterPath,
        required this.questions,
    });

    GameModel copyWith({
        String? nameGame,
        String? posterPath,
        List<Question>? questions,
    }) => 
        GameModel(
            nameGame: nameGame ?? this.nameGame,
            posterPath: posterPath ?? this.posterPath,
            questions: questions ?? this.questions,
        );

    factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        nameGame: json["nameGame"],
        posterPath: json["posterPath"],
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nameGame": nameGame,
        "posterPath": posterPath,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Question {
  final List<Option> options;
  final String text;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.options,
    required this.text,
    this.isLocked = false,
    this.selectedOption,
  });

  Question copyWith({
    List<Option>? options,
    String? text,
    bool? isLocked,
    Option? selectedOption,
  }) =>
      Question(
        options: options ?? this.options,
        text: text ?? this.text,
        isLocked: isLocked ?? this.isLocked,
        selectedOption: selectedOption ?? this.selectedOption,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        options: List<Option>.from(
            json["options"].map((x) => Option.fromJson(x))),
        text: json["text"],
        isLocked: json["isLocked"] ?? false,
        selectedOption: json["selectedOption"] != null
            ? Option.fromJson(json["selectedOption"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "text": text,
        "isLocked": isLocked,
        "selectedOption": selectedOption?.toJson(),
      };
}

class Option {
    final bool isCorrect;
    final String text;

    Option({
        required this.isCorrect,
        required this.text,
    });

    Option copyWith({
        bool? isCorrect,
        String? text,
    }) => 
        Option(
            isCorrect: isCorrect ?? this.isCorrect,
            text: text ?? this.text,
        );

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        isCorrect: json["isCorrect"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "isCorrect": isCorrect,
        "text": text,
    };
}
