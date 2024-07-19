import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trivia_app/data/model/trivia_category.dart';

const List<TriviaCategory> kCategories = [
  TriviaCategory(9, 'General'),
  TriviaCategory(10, 'Books'),
  TriviaCategory(11, 'Film'),
  TriviaCategory(12, 'Music'),
  TriviaCategory(13, 'Musicals'),
  TriviaCategory(14, 'Television'),
  TriviaCategory(15, 'Video game'),
  TriviaCategory(16, 'Board game'),
  TriviaCategory(17, 'Science'),
  TriviaCategory(18, 'Computers'),
  TriviaCategory(19, 'Maths'),
  TriviaCategory(20, 'Mythology'),
  TriviaCategory(21, 'Sports'),
  TriviaCategory(22, 'Geography'),
  TriviaCategory(23, 'History'),
  TriviaCategory(24, 'Politics'),
  TriviaCategory(25, 'Art'),
  TriviaCategory(26, 'Celebrities'),
  TriviaCategory(27, 'Animals'),
  TriviaCategory(28, 'Vehicles'),
  TriviaCategory(29, 'Comics'),
  TriviaCategory(30, 'Gadgets'),
  TriviaCategory(31, 'Anime'),
  TriviaCategory(32, 'Cartoons'),
];

Map<int, Color> color = {
  50: const Color.fromRGBO(224, 187, 97, .1),
  100: const Color.fromRGBO(224, 187, 97, .2),
  200: const Color.fromRGBO(224, 187, 97, .3),
  300: const Color.fromRGBO(224, 187, 97, .4),
  400: const Color.fromRGBO(224, 187, 97, .5),
  500: const Color.fromRGBO(224, 187, 97, .6),
  600: const Color.fromRGBO(224, 187, 97, .7),
  700: const Color.fromRGBO(224, 187, 97, .8),
  800: const Color.fromRGBO(224, 187, 97, .9),
  900: const Color.fromRGBO(224, 187, 97, 1),
};

final difficultyList = ['Easy', 'Medium', 'Hard'];
final triviaTypeList = ['True/False', 'Multiple Choice'];

const pageAnimationDuration = Duration(milliseconds: 300);

const sliderValueIdentifier = 'slider_value';
const categoryIdentifier = 'category';
const difficultyIdentifier = 'difficulty';
const triviaTypeIdentifier = 'triviaType';

const questionIdentifier = 'question';
const correctAnswerIdentifier = 'correct_answer';
const incorrectAnswersIdentifier = 'incorrect_answers';

const headingTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);
