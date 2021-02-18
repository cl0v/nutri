class DrinkModel {
  String title;
  String img;
  String desc;

  //TODO: Pensar em como passar um drink no cardapio diario...
  //TODO: Criar model que definde o cardapio do dia( o model final, mais importante para o home)
  //TODO: Tera uma lista de Meal + uma bebida????????

  DrinkModel({this.title, this.img, this.desc});

  DrinkModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['img'] = this.img;
    data['desc'] = this.desc;
    return data;
  }
}
