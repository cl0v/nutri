import 'dart:convert';

class FAQModel {
  String question;
  String answer;

  FAQModel({this.question, this.answer});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  factory FAQModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FAQModel(
      question: map['question'],
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FAQModel.fromJson(String source) =>
      FAQModel.fromMap(json.decode(source));

  @override
  String toString() => 'FAQModel(question: $question, answer: $answer)';
}
