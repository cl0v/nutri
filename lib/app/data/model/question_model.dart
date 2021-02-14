import 'dart:convert';

class Question {
  final String pref;
  final String question;
  final List<String> options;

  Question({ this.question, this.pref, this.options});

  Map<String, dynamic> toMap() {
    return {
      'pref': pref,
      'question': question,
      'options': options,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Question(
      pref: map['pref'],
      question: map['question'],
      options: List<String>.from(map['options']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) => Question.fromMap(json.decode(source));
}

//TODO: Trocar o id pelo valor da pergunta na lista
const List sample_data = [
  {
    "id": 1,
    "pref": "foodIncome",
    "question": "De onde vem a sua comida",
    "options": ['Eu cozinho', 'Costumo comer fora', 'Alguem cozinha', 'Outro'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "pref": "diabetes",
    "question": "Você tem diabetes?",
    "options": ['Sim', 'Não', 'Não sei', 'Não responder'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "pref": "pressao",
    "question": "Você tem problemas de pressão",
    "options": ['Sim, pressão alta', 'Sim, pressão baixa', 'Não', 'Não sei'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "pref": "diets",
    "question": "Já fez alguma dessas dietas?",
    "options": [
      'Dieta Low Carb',
      'Dieta Low Fat',
      'Apenas jejum intermitente',
      'Nenhuma'
    ],
    "answer_index": 2,
  },
];
