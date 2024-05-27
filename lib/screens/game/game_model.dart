import 'package:flutter_fiveflix/utils/utils_exports.dart';

class GameModel {
  final String nameGame;
  final String posterPath;
  final List<Question> questions;

  GameModel({
    required this.nameGame,
    required this.posterPath,
    required this.questions,
  });
}

class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;

  Option({required this.text, required this.isCorrect});
}

abstract class GameQuestions {
  static List<GameModel> games() {
    return [
      GameModel(
        nameGame: 'Guess the movie: Easy 😁',
        posterPath: FiveflixAssetsManager.gameGuessTheMovie,
        questions: [
          Question(
            text: '😁😡😭😱',
            options: [
              Option(
                text: 'Toy Story',
                isCorrect: false,
              ),
              Option(
                text: 'Up',
                isCorrect: false,
              ),
              Option(
                text: 'Inside Out',
                isCorrect: true,
              ),
            ],
          ),
          Question(
            text: '🔥💦🌃',
            options: [
              Option(
                text: 'Mulan',
                isCorrect: false,
              ),
              Option(
                text: 'Elemental',
                isCorrect: true,
              ),
              Option(
                text: 'Avatar 2',
                isCorrect: false,
              ),
            ],
          ),
          Question(
            text: '🧙‍♂️🧝‍♀️🧝‍♂️🧝‍♀️🧙‍♂️',
            options: [
              Option(
                text: 'Harry Potter',
                isCorrect: true,
              ),
              Option(
                text: 'The Lord of the Rings',
                isCorrect: false,
              ),
              Option(
                text: 'Percy Jackson',
                isCorrect: false,
              ),
            ],
          ),
          Question(
            text: '🐟🐠🐡🦀🐬',
            options: [
              Option(
                text: 'Finding Nemo',
                isCorrect: true,
              ),
              Option(
                text: 'Shark Tale',
                isCorrect: false,
              ),
              Option(
                text: 'The Little Mermaid',
                isCorrect: false,
              ),
            ],
          ),
          Question(
            text: '👽🚲🌌',
            options: [
              Option(
                text: 'E.T.',
                isCorrect: true,
              ),
              Option(
                text: 'Close Encounters of the Third Kind',
                isCorrect: false,
              ),
              Option(
                text: 'Star Wars',
                isCorrect: false,
              ),
            ],
          ),
        ],
      ),
      GameModel(
        nameGame: 'Guess the movie: Hard 🥵',
        posterPath: FiveflixAssetsManager.gameGuessTheMovie,
        questions: [
          Question(
            text: '🎩🐇🌀',
            options: [
              Option(text: 'Alice in Wonderland', isCorrect: true),
              Option(
                  text: 'Willy Wonka & the Chocolate Factory',
                  isCorrect: false),
              Option(text: 'The Prestige', isCorrect: false),
            ],
          ),
          Question(
            text: '🕰️⏱️👩‍👦‍👦',
            options: [
              Option(text: 'Back to the Future', isCorrect: true),
              Option(text: 'Inception', isCorrect: false),
              Option(text: 'Interstellar', isCorrect: false),
            ],
          ),
          Question(
            text: '🚗💨🕵️‍♂️',
            options: [
              Option(text: 'The Fast and the Furious', isCorrect: true),
              Option(text: 'Gone in 60 Seconds', isCorrect: false),
              Option(text: 'Need for Speed', isCorrect: false),
            ],
          ),
          Question(
            text: '🚀🛸👽',
            options: [
              Option(text: 'Alien', isCorrect: true),
              Option(text: 'Predator', isCorrect: false),
              Option(text: 'Mars Attacks!', isCorrect: false),
            ],
          ),
          Question(
            text: '🦕🦖🌴',
            options: [
              Option(text: 'Jurassic Park', isCorrect: true),
              Option(text: 'The Land Before Time', isCorrect: false),
              Option(text: 'King Kong', isCorrect: false),
            ],
          ),
        ],
      )
    ];
  }
}
