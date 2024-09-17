import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/state/quiz_state.dart';

class DetailsPage extends ConsumerWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quiz = ref.watch(quizProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
      ),
      body: quiz.when(data: (data) {
        return ListView.builder(
          itemCount: data.results.length,
          itemBuilder: (context, index) {},
        );
      }, error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
