import 'package:trivia_app/core/constants/constants.dart';

class QuestionEntryBucket {}

/// Class responsible for modelling the individual question and answers
class QuestionEntry {
  QuestionEntry({
    required this.questionData,
  }) {
    final options = <String>[
      ...questionData[incorrectAnswersIdentifier],
      questionData[correctAnswerIdentifier]
    ];
    options.shuffle();
    shuffledOptions = options;
  }

  final Map<String, dynamic> questionData;
  late final List<String> shuffledOptions;

  String get question => questionData[questionIdentifier];
  String get correctAnswer => questionData[correctAnswerIdentifier];
}
