import 'package:application/screens/record_screen.dart';
import 'package:application/styles/color_styles.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ColorStyles.primary,
        scaffoldBackgroundColor: ColorStyles.background,
        useMaterial3: true,
        fontFamily: 'NanumBarunGothic',
        //ref: https://api.flutter.dev/flutter/material/TextTheme-class.html
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      home: const RecordScreen(),
    );
  }
}
