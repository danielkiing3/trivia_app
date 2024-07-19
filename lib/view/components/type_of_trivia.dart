import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/data/model/trivia_category.dart';
import 'package:trivia_app/view/providers/trivia_builder_provider.dart';
import 'package:trivia_app/view/screens/exercise_screen.dart';
import 'package:trivia_app/view/widgets/long_button.dart';
import 'package:trivia_app/view/widgets/option_button.dart';
import 'package:http/http.dart' as http;

class TypeOfTrivia extends ConsumerStatefulWidget {
  const TypeOfTrivia({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TypeOfTriviaState();
  }
}

class _TypeOfTriviaState extends ConsumerState<TypeOfTrivia> {
  bool isWaiting = false;

  void getQuestionData(WidgetRef ref, BuildContext context) async {
    final triviaSetting = ref.read(triviaBuilderProvider);
    final amount = triviaSetting[sliderValueIdentifier];
    final category = triviaSetting[categoryIdentifier] as TriviaCategory;
    final difficulty = triviaSetting[difficultyIdentifier].toLowerCase();
    final triviaType = triviaSetting[triviaTypeIdentifier] == 'True/False'
        ? "boolean"
        : 'multiple';

    final queryString =
        'amount=$amount&category=${category.id}&difficulty=$difficulty&type=$triviaType';
    final url = 'https://opentdb.com/api.php?$queryString';

    setState(() {
      isWaiting = true;
    });

    try {
      final response = await http.get(Uri.parse(url));

      setState(() {
        isWaiting = false;
      });

      final responseBody = utf8.decode(response.bodyBytes);
      final data = json.decode(responseBody);
      final rawData = data['results'] as List<dynamic>;

      if (context.mounted) {
        if (rawData.isEmpty) {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog.adaptive(
                title: const Text('No available question'),
                content: const Text('Try a different question set'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okay'),
                  )
                ],
              );
            },
          );

          return;
        }
        Navigator.of(context).push(
          Platform.isIOS
              ? CupertinoPageRoute(
                  builder: (ctx) => ExerciseScreen(rawData: rawData),
                )
              : MaterialPageRoute(
                  builder: (ctx) => ExerciseScreen(rawData: rawData),
                ),
        );
      }
    } catch (error) {
      setState(() {
        isWaiting = false;
      });
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog.adaptive(
                content: const Text(
                    'You have mo internet connection. Check your connection and try again later'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okay'),
                  )
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Select a type of trivia', style: headingTextStyle),
        const SizedBox(height: 20),
        Expanded(
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 1,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
            ),
            children: triviaTypeList
                .map((type) => OptionButton(
                      name: type,
                      triviaType: type,
                    ))
                .toList(),
          ),
        ),
        isWaiting
            ? Platform.isIOS
                ? const CupertinoActivityIndicator(radius: 20)
                : const CircularProgressIndicator()
            : LongButton(
                text: 'Get Trivia',
                onTap: () {
                  getQuestionData(ref, context);
                },
              ),
        const SizedBox(height: 5),
      ],
    );
  }
}
