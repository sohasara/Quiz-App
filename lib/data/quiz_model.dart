// ignore_for_file: public_member_api_docs, sort_constructors_first

class QuizQuestion {
  String question;

  String correctAnswer;

  List<String> incorrectAnswer;
  QuizQuestion({
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswer: List<String>.from(json['incorrect_answer']),
    );
  }
}
