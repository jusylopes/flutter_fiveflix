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

class SerieDetailModel {
    final String nameGame;
    final String posterPath;
    final List<Question> questions;

    SerieDetailModel({
        required this.nameGame,
        required this.posterPath,
        required this.questions,
    });

    SerieDetailModel copyWith({
        String? nameGame,
        String? posterPath,
        List<Question>? questions,
    }) => 
        SerieDetailModel(
            nameGame: nameGame ?? this.nameGame,
            posterPath: posterPath ?? this.posterPath,
            questions: questions ?? this.questions,
        );
}

class Question {
    final List<Option> options;
    final String text;

    Question({
        required this.options,
        required this.text,
    });

    Question copyWith({
        List<Option>? options,
        String? text,
    }) => 
        Question(
            options: options ?? this.options,
            text: text ?? this.text,
        );
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
}
