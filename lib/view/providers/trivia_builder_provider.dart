import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/data/model/trivia_category.dart';

class TriviaBuilderNotifier extends StateNotifier<Map<String, dynamic>> {
  TriviaBuilderNotifier()
      : super({
          sliderValueIdentifier: 5,
          categoryIdentifier: kCategories[0],
          difficultyIdentifier: 'Easy',
          triviaTypeIdentifier: 'True/False'
        });

  void updateSliderValue(double sliderValue) {
    state = {
      ...state,
      sliderValueIdentifier: sliderValue.toInt(),
    };
  }

  void updateCategoryValue(TriviaCategory category) {
    state = {
      ...state,
      categoryIdentifier: category,
    };
  }

  void updateDifficultyValue(String difficulty) {
    state = {
      ...state,
      difficultyIdentifier: difficulty,
    };
  }

  void updateTriviaTypeValue(String triviaType) {
    state = {
      ...state,
      triviaTypeIdentifier: triviaType,
    };
  }

  void resetData() {
    state = {
      sliderValueIdentifier: 5,
      categoryIdentifier: kCategories[0],
      difficultyIdentifier: 'Easy',
      triviaTypeIdentifier: 'True/False'
    };
  }
}

final triviaBuilderProvider =
    StateNotifierProvider<TriviaBuilderNotifier, Map<String, dynamic>>(
  (ref) {
    return TriviaBuilderNotifier();
  },
);
