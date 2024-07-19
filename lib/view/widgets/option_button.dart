import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/data/model/trivia_category.dart';
import 'package:trivia_app/view/providers/trivia_builder_provider.dart';

class OptionButton extends ConsumerWidget {
  const OptionButton({
    super.key,
    required this.name,
    this.category,
    this.difficulty,
    this.triviaType,
  });

  final String name;
  final TriviaCategory? category;
  final String? difficulty;
  final String? triviaType;

  void _toggleButton(WidgetRef ref) {
    if (category != null) {
      ref.watch(triviaBuilderProvider.notifier).updateCategoryValue(category!);
    }

    if (difficulty != null) {
      ref
          .watch(triviaBuilderProvider.notifier)
          .updateDifficultyValue(difficulty!);
    }

    if (triviaType != null) {
      ref
          .watch(triviaBuilderProvider.notifier)
          .updateTriviaTypeValue(triviaType!);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = false;
    if (category == ref.watch(triviaBuilderProvider)['category'] &&
        category != null) {
      isSelected = true;
    }

    if (difficulty == ref.watch(triviaBuilderProvider)['difficulty'] &&
        difficulty != null) {
      isSelected = true;
    }

    if (triviaType == ref.watch(triviaBuilderProvider)['triviaType'] &&
        triviaType != null) {
      isSelected = true;
    }

    return Container(
      child: isSelected
          ? ElevatedButton(
              onPressed: () {
                _toggleButton(ref);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            )
          : OutlinedButton(
              onPressed: () {
                _toggleButton(ref);
              },
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
    );
  }
}
