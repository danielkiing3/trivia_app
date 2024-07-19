import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/view/screens/trivia_settings_screen.dart';
import 'package:trivia_app/view/widgets/long_button.dart';

/// The home welcome screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Welcome to the Triva App',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                LongButton(
                  text: 'Begin Trivia',
                  onTap: () => Navigator.of(context).push(
                    Platform.isIOS
                        ? CupertinoPageRoute(
                            builder: (ctx) => const TriviaSettingsScreen(),
                          )
                        : MaterialPageRoute(
                            builder: (ctx) => const TriviaSettingsScreen(),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
