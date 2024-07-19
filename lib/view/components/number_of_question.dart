import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/view/providers/trivia_builder_provider.dart';
import 'package:trivia_app/view/widgets/long_button.dart';

class NumberOfQuestion extends ConsumerWidget {
  const NumberOfQuestion({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sliderValue = ref.watch(triviaBuilderProvider)[sliderValueIdentifier];
    return Column(
      children: [
        const Text(
          'How many questions would you like to answer?',
          textAlign: TextAlign.center,
          style: headingTextStyle,
        ),
        const SizedBox(height: 20),
        const Spacer(),
        Text('${sliderValue.toInt()}', style: headingTextStyle),
        Slider.adaptive(
          value: sliderValue.toDouble(),
          onChanged: (value) {
            ref.read(triviaBuilderProvider.notifier).updateSliderValue(value);
          },
          divisions: 2,
          min: 5,
          max: 15,
        ),
        const Spacer(),
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
