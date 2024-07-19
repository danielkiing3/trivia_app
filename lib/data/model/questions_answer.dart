// Takes in all map data

// Sample data
// {
//       "type": "multiple",
//       "difficulty": "easy",
//       "category": "Entertainment: Japanese Anime &amp; Manga",
//       "question": "Who is the true moon princess in Sailor Moon?",
//       "correct_answer": "Sailor Moon",
//       "incorrect_answers": [
//         "Sailor Venus",
//         "Sailor Mars",
//         "Sailor Jupiter"
//       ]
//     },

// Getting a new shuffled list of options
// options = [...incorrect_answers, correct_answers]
// options.shuffle()

// Variable to store an correct answers  numberOfCorrectlyAnswered

// Functions to check if the answer is correct
// Shown answer == correct_answer / Update numberOfCorrectlyAnswered

import 'package:trivia_app/data/model/question_entry.dart';

class QuestionsAnswer {
  QuestionsAnswer({
    required this.id,
    required this.choosenAnswer,
    required this.questionData,
  }) {
    correctAnswer = questionData.correctAnswer; // Initialization work
  }

  final int id;
  final String choosenAnswer;
  final QuestionEntry questionData;
  late String correctAnswer;

  bool get correctlyAnswer {
    if (choosenAnswer == correctAnswer) {
      return true;
    } else {
      return false;
    }
  }
}
