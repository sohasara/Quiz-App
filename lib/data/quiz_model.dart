// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class QuizQuestion extends HiveObject {
  @HiveField(0)
  String category;
  @HiveField(1)
  String type;
  @HiveField(2)
  String question;
  @HiveField(3)
  String correctAnswer;
  @HiveField(4)
  List<String> incorrectAnswer;
  QuizQuestion({
    required this.category,
    required this.type,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswer,
  });
}
