// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: non_constant_identifier_names

class SportsData {
  final String type;
  final String category;
  final String question;
  final String correct_answer;
  final String incorrect_answers;

  SportsData({
    required this.type,
    required this.category,
    required this.question,
    required this.correct_answer,
    required this.incorrect_answers,
  });

  factory SportsData.fromMap(Map<String, dynamic> map) {
    return SportsData(
      type: map['type'] as String,
      category: map['category'] as String,
      question: map['question'] as String,
      correct_answer: map['correct_answer'] as String,
      incorrect_answers: map['incorrect_answers'] as String,
    );
  }
}
