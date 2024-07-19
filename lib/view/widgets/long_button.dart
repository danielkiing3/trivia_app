import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/view/providers/choosen_answer_provider.dart';

class LongButton extends ConsumerWidget {
  const LongButton({
    super.key,
    this.text = 'Continue',
    this.id,
    this.questionIndex,
    required this.onTap,
  });

  final String? text;
  final int? id;
  final int? questionIndex;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final answerState = ref.watch(choosenAnswerProvider);

    if (id != null && id != answerState[questionIndex]?.id) {
      return OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 70),
        ),
        child: Text(
          text!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      );
    }

    if (id == answerState[questionIndex]?.id && id != null) {
      return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 70),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
          text!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      );
    } else {
      return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 70),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
          text!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      );
    }
  }
}
