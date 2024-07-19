import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/view/widgets/long_button.dart';
import 'package:trivia_app/view/widgets/option_button.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text('Select a category', style: headingTextStyle),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.builder(
            itemCount: kCategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 1.5,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              return kCategories
                  .map(
                    (categoryItem) => OptionButton(
                      name: categoryItem.name,
                      category: categoryItem,
                    ),
                  )
                  .toList()[index];
            },
          ),
        ),
        LongButton(
          onTap: () {
            pageController.nextPage(
                duration: pageAnimationDuration, curve: Curves.easeInOut);
          },
        )
      ],
    );
  }
}
