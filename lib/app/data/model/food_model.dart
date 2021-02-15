class FoodModel {
  String title;
  String prefs;
  String img;
  List<String> preparo;
  Tabela tabela;

  FoodModel({
    this.title,
    this.prefs,
    this.img,
    this.preparo,
    this.tabela,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    prefs = json['prefs'];
    img = json['img'];
    preparo = json['preparo'].cast<String>();
    tabela =
        json['tabela'] != null ? new Tabela.fromJson(json['tabela']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['prefs'] = this.prefs;
    data['img'] = this.img;
    data['preparo'] = this.preparo;
    if (this.tabela != null) {
      data['tabela'] = this.tabela.toJson();
    }
    return data;
  }
}

class Tabela {
  double calorias;
  double carboidrato;
  double fibra;
  double gordura;
  double proteina;

  Tabela({
    this.calorias,
    this.carboidrato,
    this.fibra,
    this.gordura,
    this.proteina,
  });

  Tabela.fromJson(Map<String, dynamic> json) {
    calorias = json['calorias'];
    carboidrato = json['carboidrato'];
    fibra = json['fibra'];
    gordura = json['gordura'];
    proteina = json['proteina'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calorias'] = this.calorias;
    data['carboidrato'] = this.carboidrato;
    data['fibra'] = this.fibra;
    data['gordura'] = this.gordura;
    data['proteina'] = this.proteina;
    return data;
  }
}
