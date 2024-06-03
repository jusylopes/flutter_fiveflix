import 'package:flutter/material.dart';
import 'package:flutter_fiveflix/screens/game/game_model.dart';
import 'package:flutter_fiveflix/screens/game/result_special_game_screen.dart';
import 'package:flutter_fiveflix/screens/game/result_game_screen.dart';
import 'package:flutter_fiveflix/utils/utils_exports.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.game});

  final GameModel game;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;
  Question? _lastQuestion;

  @override
  void initState() {
    super.initState();
    _lastQuestion = null;
    _controller = PageController(initialPage: 0);
    _resetGameState();
  }

  void _resetGameState() {
    setState(() {
      _questionNumber = 1;
      _score = 0;
      for (var question in widget.game.questions) {
        question.isLocked = false;
        question.selectedOption = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.game.nameGame,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              'Question $_questionNumber / ${widget.game.questions.length}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: widget.game.questions.length,
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final question = widget.game.questions[index];
                final isSpecialGame =
                    widget.game.nameGame == FiveflixStrings.specialGame;
                return buildQuestion(
                  question,
                  context,
                  isSpecialGame,
                );
              },
            ),
          ),
          _isLocked ? buildElevatedButton() : const SizedBox.shrink(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Column buildQuestion(
    Question question,
    BuildContext context,
    bool isSpecialGame,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 15),
          child: Text(
            question.text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: OptionsWidget(
            isSpecialGame: isSpecialGame,
            question: question,
            onClickedOption: (option) {
              if (question.isLocked) {
                return;
              } else {
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                  _lastQuestion = question;
                });
              }
              _isLocked = question.isLocked;
              if (question.selectedOption!.isCorrect) {
                _score++;
              }
            },
          ),
        ),
      ],
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        if (_questionNumber < widget.game.questions.length) {
          _controller.nextPage(
            duration: const Duration(
              milliseconds: 250,
            ),
            curve: Curves.easeInExpo,
          );

          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          if (widget.game.nameGame == FiveflixStrings.specialGame) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultEspecialGameScreen(
                  selectedOption: _lastQuestion?.selectedOption?.text ??
                      'No option selected',
                ),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultGameScreen(
                  score: _score,
                  numberQuestions: widget.game.questions.length,
                ),
              ),
            );
          }
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: FiveflixColors.primaryColor,
      ),
      child: Text(
        _questionNumber < widget.game.questions.length
            ? 'Next page'
            : 'See the result',
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({
    super.key,
    required this.question,
    required this.onClickedOption,
    required this.isSpecialGame,
  });

  final Question question;
  final ValueChanged<Option> onClickedOption;
  final bool isSpecialGame;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: question.options
            .map(
              (option) => buildOption(
                  context, option, question, onClickedOption, isSpecialGame),
            )
            .toList(),
      ),
    );
  }
}

Widget buildOption(
  BuildContext context,
  Option option,
  Question question,
  ValueChanged<Option> onClickedOption,
  bool isSpecialGame,
) {
  final color = getColorForOption(option, question, isSpecialGame);

  return GestureDetector(
    onTap: () => onClickedOption(option),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 15,
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              option.text,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          getIconForOption(option, question, isSpecialGame),
        ],
      ),
    ),
  );
}

Color getColorForOption(option, question, bool isSpecialGame) {
  final isSelected = option == question.selectedOption;

  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect
          ? FiveflixColors.gameQuestionSucess
          : FiveflixColors.gameQuestionIncorrectColor;
    } else if (option.isCorrect && isSpecialGame == false) {
      return FiveflixColors.gameQuestionDefaultColor;
    }
  }

  return FiveflixColors.gameQuestionDefaultColor;
}

Widget getIconForOption(Option option, Question question, bool isSpecialGame) {
  final isSelected = option == question.selectedOption;

  if (question.isLocked) {
    if (isSelected) {
      return option.isCorrect
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : const Icon(
              Icons.cancel,
              color: Colors.red,
            );
    } else if (option.isCorrect && isSpecialGame == false) {
      return const Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    }
  }
  return const SizedBox.shrink();
}
