import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/view/providers/choosen_answer_provider.dart';
import 'package:trivia_app/view/providers/trivia_builder_provider.dart';
import 'package:trivia_app/view/widgets/long_button.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({
    super.key,
    required this.correctlyAnswered,
    required this.numberOfQuestions,
  });

  final int correctlyAnswered;
  final int numberOfQuestions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'You got $correctlyAnswered out of $numberOfQuestions questions correctly',
                textAlign: TextAlign.center,
                style: headingTextStyle,
              ),
              const Spacer(),
              LongButton(
                onTap: () {
                  // Navigate to the result page
                },
                text: 'See correct answers',
              ),
              const SizedBox(
                height: 12,
              ),
              LongButton(
                onTap: () {
                  ref.read(triviaBuilderProvider.notifier).resetData();
                  ref.read(choosenAnswerProvider.notifier).resetData();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });
                },
                text: 'Home 🏡',
                id: -100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
