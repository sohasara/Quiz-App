import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:quiz_app/data/quiz_model.dart';

import 'package:quiz_app/ui/splash_page/splash.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuizQuestionAdapter());
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        //textTheme:
      ),
      home: const SplashPage(),
    );
  }
}
