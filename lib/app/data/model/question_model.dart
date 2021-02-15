class QuestionModel {
  String question;
  String prefs;
  List<String> options;

  QuestionModel({this.question, this.prefs, this.options});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    prefs = json['prefs'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['prefs'] = this.prefs;
    data['options'] = this.options;
    return data;
  }
}