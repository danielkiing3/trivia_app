import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/data/model/question_entry.dart';
import 'package:trivia_app/data/model/questions_answer.dart';

typedef ChoosenAnswerState = Map<int, QuestionsAnswer>;

class ChoosenAnswerNotifier extends StateNotifier<ChoosenAnswerState> {
  ChoosenAnswerNotifier() : super({});

  void updateChoosenAnswer(
    int questionIndex,
    int optionId,
    String choosenAnswer,
    QuestionEntry questionData,
  ) {
    final newState = state;
    newState[questionIndex] = QuestionsAnswer(
      id: optionId,
      choosenAnswer: choosenAnswer,
      questionData: questionData,
    );
    state = newState;
  }

  void resetData() {
    state = {};
  }

  int numberOfCorrectlyAnswered() {
    int value = 0;

    for (var questionData in state.values) {
      if (questionData.correctlyAnswer) {
        value++;
      }
    }

    // state.forEach(
    //   (index, questionData) {
    //     if (questionData.correctlyAnswer) {
    //       value++;
    //     }
    //   },
    // );

    return value;
  }

  void resetState() {
    state = {};
  }
}

final choosenAnswerProvider =
    StateNotifierProvider<ChoosenAnswerNotifier, ChoosenAnswerState>(
  (ref) => ChoosenAnswerNotifier(),
);
