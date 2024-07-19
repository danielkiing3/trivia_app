import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.numberOfQuestions,
    required this.selectedQuestionIndex,
  });

  final int numberOfQuestions;
  final int selectedQuestionIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(numberOfQuestions, (int questionIndex) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: questionIndex < selectedQuestionIndex
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ),
          ),
        );
      }, growable: false),
    );
  }
}
