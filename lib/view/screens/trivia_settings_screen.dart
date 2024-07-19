import 'package:flutter/material.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/view/components/number_of_question.dart';
import 'package:trivia_app/view/components/select_category.dart';
import 'package:trivia_app/view/components/select_difficulty.dart';
import 'package:trivia_app/view/components/type_of_trivia.dart';

class TriviaSettingsScreen extends StatefulWidget {
  const TriviaSettingsScreen({super.key});

  @override
  State<TriviaSettingsScreen> createState() => _TriviaSettingsScreenState();
}

class _TriviaSettingsScreenState extends State<TriviaSettingsScreen> {
  int _selectedPageIndex = 0;
  late PageController _pageController;

  /// Inititalization work of the [PageController]
  @override
  void initState() {
    _pageController = PageController(
      initialPage: _selectedPageIndex,
    );
    super.initState();
  }

  /// Disposes of the [PageController] to free up resources and prevent memory leaks
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List to store all the available screen
    final List<Widget> pages = [
      NumberOfQuestion(pageController: _pageController),
      SelectCategory(pageController: _pageController),
      SelectDifficulty(pageController: _pageController),
      const TypeOfTrivia(),
    ];

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (_pageController.hasClients) {
          _pageController.previousPage(
            duration: pageAnimationDuration,
            curve: Curves.easeInOut,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: _selectedPageIndex == 0
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.previousPage(
                        duration: pageAnimationDuration,
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  icon: const Icon(Icons.arrow_back)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pages.length,
              onPageChanged: (value) {
                setState(() {
                  _selectedPageIndex = value;
                });
              },
              itemBuilder: (ctx, index) => pages[index],
            ),
          ),
        ),
      ),
    );
  }
}
