import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/view/widgets/long_button.dart';
import 'package:trivia_app/view/widgets/option_button.dart';

class SelectDifficulty extends ConsumerWidget {
  const SelectDifficulty({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text('Select a difficulty', style: headingTextStyle),
        const SizedBox(height: 20),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 1.5,
              crossAxisSpacing: 10,
            ),
            children: difficultyList
                .map((difficulty) => OptionButton(
                      name: difficulty,
                      difficulty: difficulty,
                    ))
                .toList(),
          ),
        ),
        LongButton(
          onTap: () {
            pageController.nextPage(
              duration: pageAnimationDuration,
              curve: Curves.easeInOut,
            );
          },
        )
      ],
    );
  }
}
