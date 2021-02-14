class Question {
  final int id, answer;
  final String question, pref;
  final List<String> options;

  Question({this.id, this.question, this.pref, this.answer, this.options});
}



const List sample_data = [
  {
    "id": 1, //TODO: Trocar o id pelo valor da pergunta na lista
    "pref" : "foodIncome",
    "question":
        "De onde vem a sua comida",
    "options": ['Eu cozinho', 'Costumo comer fora', 'Alguem cozinha', 'Outro'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "pref" : "diabetes",
    "question": "Você tem diabetes?",
    "options": ['Sim', 'Não', 'Não sei', 'Não responder'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "pref" : "pressao",
    "question": "Você tem problemas de pressão",
    "options": ['Sim, pressão alta', 'Sim, pressão baixa', 'Não', 'Não sei'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "pref" : "diets",
    "question": "Já fez alguma dessas dietas?",
    "options": ['Dieta Low Carb', 'Dieta Low Fat', 'Apenas jejum intermitente', 'Nenhuma'],
    "answer_index": 2,
  },
];
