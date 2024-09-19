class QuizQuestion {
  String question;
  String correctAnswer;
  List<String> incorrectAnswer;

  QuizQuestion({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswer,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      question: map['question'] ?? '',
      correctAnswer: map['correct_answer'] ?? '',
      // Ensure you're using 'incorrect_answers' (plural) as per the API response
      incorrectAnswer: List<String>.from(map['incorrect_answers'] ?? []),
    );
  }
}
