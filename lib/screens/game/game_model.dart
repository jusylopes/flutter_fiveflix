import 'dart:convert';

import 'package:flutter_fiveflix/utils/utils_exports.dart';

class GameModelVersion1 {
  final String nameGame;
  final String posterPath;
  final List<QuestionVersion1> questions;

  GameModelVersion1({
    required this.nameGame,
    required this.posterPath,
    required this.questions,
  });
}

class QuestionVersion1 {
  final String text;
  final List<OptionVersion1> options;
  bool isLocked;
  OptionVersion1? selectedOption;

  QuestionVersion1({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class OptionVersion1 {
  final String text;
  final bool isCorrect;

  OptionVersion1({required this.text, required this.isCorrect});
}

abstract class GameQuestions {
  static List<GameModelVersion1> games() {
    return [
      GameModelVersion1(
        nameGame: 'Guess the movie by emoji: Easy 😁',
        posterPath: FiveflixAssetsManager.gameGuessTheMovie,
        questions: [
          QuestionVersion1(
            text: '😁😡😭😱',
            options: [
              OptionVersion1(
                text: 'Toy Story',
                isCorrect: false,
              ),
              OptionVersion1(
                text: 'Up',
                isCorrect: false,
              ),
              OptionVersion1(
                text: 'Inside Out',
                isCorrect: true,
              ),
            ],
          ),
          QuestionVersion1(
            text: '🔥💦🌃',
            options: [
              OptionVersion1(
                text: 'Mulan',
                isCorrect: false,
              ),
              OptionVersion1(
                text: 'Elemental',
                isCorrect: true,
              ),
              OptionVersion1(
                text: 'Avatar 2',
                isCorrect: false,
              ),
            ],
          ),
          QuestionVersion1(
            text: '🧙‍♂️🧝‍♀️🧝‍♂️🧝‍♀️🧙‍♂️',
            options: [
              OptionVersion1(
                text: 'Harry Potter',
                isCorrect: true,
              ),
              OptionVersion1(
                text: 'The Lord of the Rings',
                isCorrect: false,
              ),
              OptionVersion1(
                text: 'Percy Jackson',
                isCorrect: false,
              ),
            ],
          ),
          QuestionVersion1(
            text: '🐟🐠🐡🦀🐬',
            options: [
              OptionVersion1(
                text: 'Finding Nemo',
                isCorrect: true,
              ),
              OptionVersion1(
                text: 'Shark Tale',
                isCorrect: false,
              ),
              OptionVersion1(
                text: 'The Little Mermaid',
                isCorrect: false,
              ),
            ],
          ),
          QuestionVersion1(
            text: '👽🚲🌌',
            options: [
              OptionVersion1(
                text: 'E.T.',
                isCorrect: true,
              ),
              OptionVersion1(
                text: 'Close Encounters of the Third Kind',
                isCorrect: false,
              ),
              OptionVersion1(
                text: 'Star Wars',
                isCorrect: false,
              ),
            ],
          ),
        ],
      ),
      GameModelVersion1(
        nameGame: 'Guess the movie by emoji: Hard 🥵',
        posterPath: FiveflixAssetsManager.gameGuessTheMovie,
        questions: [
          QuestionVersion1(
            text: '🎩🐇🌀',
            options: [
              OptionVersion1(text: 'Alice in Wonderland', isCorrect: true),
              OptionVersion1(
                  text: 'Willy Wonka & the Chocolate Factory',
                  isCorrect: false),
              OptionVersion1(text: 'The Prestige', isCorrect: false),
            ],
          ),
          QuestionVersion1(
            text: '🕰️⏱️👩‍👦‍👦',
            options: [
              OptionVersion1(text: 'Back to the Future', isCorrect: true),
              OptionVersion1(text: 'Inception', isCorrect: false),
              OptionVersion1(text: 'Interstellar', isCorrect: false),
            ],
          ),
          QuestionVersion1(
            text: '🚗💨🕵️‍♂️',
            options: [
              OptionVersion1(text: 'The Fast and the Furious', isCorrect: true),
              OptionVersion1(text: 'Gone in 60 Seconds', isCorrect: false),
              OptionVersion1(text: 'Need for Speed', isCorrect: false),
            ],
          ),
          QuestionVersion1(
            text: '🚀🛸👽',
            options: [
              OptionVersion1(text: 'Alien', isCorrect: true),
              OptionVersion1(text: 'Predator', isCorrect: false),
              OptionVersion1(text: 'Mars Attacks!', isCorrect: false),
            ],
          ),
          QuestionVersion1(
            text: '🦕🦖🌴',
            options: [
              OptionVersion1(text: 'Jurassic Park', isCorrect: true),
              OptionVersion1(text: 'The Land Before Time', isCorrect: false),
              OptionVersion1(text: 'King Kong', isCorrect: false),
            ],
          ),
        ],
      )
    ];
  }
}

//-------------------------------------------------- fim do version 1 -----------------------------------------------------------------//

List<GameModel> gameModelFromJson(String str) =>
    List<GameModel>.from(json.decode(str).map((x) => GameModel.fromJson(x)));

String gameModelToJson(List<GameModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nameGame": nameGame,
        "posterPath": posterPath,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  final String text;
  final List<Option> options;

  Question({
    required this.text,
    required this.options,
  });

  Question copyWith({
    String? text,
    List<Option>? options,
  }) =>
      Question(
        text: text ?? this.text,
        options: options ?? this.options,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json["text"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Option {
  final String text;
  final bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect,
  });

  Option copyWith({
    String? text,
    bool? isCorrect,
  }) =>
      Option(
        text: text ?? this.text,
        isCorrect: isCorrect ?? this.isCorrect,
      );

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        text: json["text"],
        isCorrect: json["isCorrect"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "isCorrect": isCorrect,
      };
}
