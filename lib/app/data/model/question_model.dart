class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({this.id, this.question, this.answer, this.options});
}



const List sample_data = [
  {
    "id": 1,
    "question":
        "De onde vem a sua comida",
    "options": ['Eu cozinho', 'Costumo comer fora', 'Alguem cozinha', 'Outro'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "Você tem diabetes?",
    "options": ['Sim', 'Não', 'Não sei', 'Não responder'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "Você tem problemas de pressão",
    "options": ['Sim, pressão alta', 'Sim, pressão baixa', 'Não', 'Não sei'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "Já fez alguma dessas dietas?",
    "options": ['Dieta Low Carb', 'Dieta Low Fat', 'Apenas jejum intermitente', 'Nenhuma'],
    "answer_index": 2,
  },
];
