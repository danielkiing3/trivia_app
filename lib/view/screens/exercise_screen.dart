import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/data/model/question_entry.dart';
import 'package:trivia_app/view/providers/choosen_answer_provider.dart';
import 'package:trivia_app/view/screens/result_screen.dart';
import 'package:trivia_app/view/widgets/long_button.dart';
import 'package:trivia_app/view/widgets/progress_bar.dart';

class ExerciseScreen extends ConsumerStatefulWidget {
  const ExerciseScreen({
    super.key,
    required this.rawData,
  });

  final List<dynamic> rawData;

  @override
  ConsumerState<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends ConsumerState<ExerciseScreen> {
  late List<QuestionEntry> trivias;
  late PageController _pageController;
  int selectedQuestionIndex = 0;
  bool answerChoosen = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: selectedQuestionIndex);
    trivias = widget.rawData
        .map((trivia) => QuestionEntry(questionData: trivia))
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        bool? shouldContinue = await showDialog<bool>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              content: const Text('Your progress will be lost'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );

        if (shouldContinue == true && context.mounted) {
          ref.read(choosenAnswerProvider.notifier).resetData();
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                ProgressBar(
                  numberOfQuestions: trivias.length,
                  selectedQuestionIndex: selectedQuestionIndex + 1,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: trivias.length,
                    onPageChanged: (value) {
                      setState(() {
                        selectedQuestionIndex = value;
                      });
                    },
                    itemBuilder: (context, questionIndex) {
                      final questionData = trivias[questionIndex];
                      final options = questionData.shuffledOptions;

                      return Column(children: [
                        const SizedBox(height: 10),
                        Text(
                          questionData.question,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (ctx, index) {
                              return LongButton(
                                onTap: () {
                                  ref
                                      .read(choosenAnswerProvider.notifier)
                                      .updateChoosenAnswer(
                                        questionIndex,
                                        index,
                                        options[index],
                                        questionData,
                                      );
                                  setState(() {
                                    answerChoosen = true;
                                  });
                                },
                                questionIndex: questionIndex,
                                id: index,
                                text: options[index],
                              );
                            },
                            separatorBuilder: (ctx, index) =>
                                const SizedBox(height: 16),
                            itemCount: options.length,
                          ),
                        ),
                        if (answerChoosen)
                          LongButton(
                            onTap: () {
                              answerChoosen = false;
                              if (selectedQuestionIndex + 1 < trivias.length) {
                                _pageController.nextPage(
                                    duration: pageAnimationDuration,
                                    curve: Curves.easeInOut);
                              } else {
                                final numberOfCorrectlyAnswered = ref
                                    .read(choosenAnswerProvider.notifier)
                                    .numberOfCorrectlyAnswered();
                                Navigator.of(context).push(
                                  Platform.isIOS
                                      ? CupertinoPageRoute(
                                          builder: (ctx) => ResultScreen(
                                            correctlyAnswered:
                                                numberOfCorrectlyAnswered,
                                            numberOfQuestions: trivias.length,
                                          ),
                                        )
                                      : MaterialPageRoute(
                                          builder: (ctx) => ResultScreen(
                                            correctlyAnswered:
                                                numberOfCorrectlyAnswered,
                                            numberOfQuestions: trivias.length,
                                          ),
                                        ),
                                );
                              }
                            },
                            text: selectedQuestionIndex + 1 < trivias.length
                                ? 'Next'
                                : 'Done',
                          ),
                      ]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
