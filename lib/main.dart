import 'package:flutter/material.dart';
import 'package:quiz_app/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(),
    );
  }
}
//https://opentdb.com/api.php?amount=10&category=17&difficulty=medium&type=multiple
//https://opentdb.com/api.php?amount=10&category=9&difficulty=medium&type=multiple
//https://opentdb.com/api.php?amount=10&category=11&difficulty=hard&type=multiple
//https://opentdb.com/api_config.php