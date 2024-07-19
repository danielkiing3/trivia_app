import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trivia_app/core/constants/constants.dart';
import 'package:trivia_app/view/screens/home_screen.dart';

final kColorScheme = ColorScheme.fromSwatch(
  primarySwatch: MaterialColor(0xFFD4A048, color),
  brightness: Brightness.dark,
).copyWith(secondary: const Color(0xFFD4A048));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 34, 39, 47),
          colorScheme: kColorScheme,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
