// ignore_for_file: non_constant_identifier_names

class SportsData {
  final String type;
  final String category;
  final String question;
  final String correct_answer;
  final List<String> incorrect_answers;

  SportsData({
    required this.type,
    required this.category,
    required this.question,
    required this.correct_answer,
    required this.incorrect_answers,
  });

  factory SportsData.fromMap(Map<String, dynamic> map) {
    return SportsData(
      type: map['type'] as String? ?? 'Unknown', // Provide default value
      category: map['category'] as String? ?? 'General',
      question: map['question'] as String? ?? 'No question available',
      correct_answer: map['correct_answer'] as String? ?? 'No answer available',
      incorrect_answers: List<String>.from(
          map['incorrect_answers'] ?? []), // Handle possible null value
    );
  }
}
