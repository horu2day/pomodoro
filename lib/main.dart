import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  int counter = 0;

  App({super.key});

  void onClicked() {
    counter = counter + 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              color: Color(0xFF232B55),
            ),
          ),
          cardColor: const Color(0xFFF4EDDB),
          colorScheme: const ColorScheme(
            surface: Colors.white,
            onSurface: Colors.white,
            onBackground: Color(0xFFE7626C),
            error: Colors.black,
            onError: Colors.black,
            onPrimary: Color(0xFFE7626C),
            onSecondary: Color(0xFF232B55),
            primary: Color(0xFF232B55),
            secondary: Color(0xFF232B55),
            brightness: Brightness.light,
            background: Color(0xFFE7626C),
          ),
        ),
        home: const HomeScreen());
  }
}
