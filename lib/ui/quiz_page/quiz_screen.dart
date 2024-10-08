import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/%20data_model/category_model.dart';
import 'package:quiz_app/ui/quiz_page/details_page.dart';

import '../../api/quiz_response.dart';

class QuizScreen extends ConsumerWidget {
  final CategoryModel category;
  const QuizScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizQuestions = ref.watch(quizQuestionsProvider(category.apiurl));

    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        centerTitle: true,
        title: Text(
          'Quiz: ${category.name}',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
      body: quizQuestions.when(
        data: (questions) => DetailsPage(questions: questions),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Failed to load questions: $error'),
        ),
      ),
    );
  }
}
