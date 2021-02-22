import 'dart:convert';

//TODO: Pensar em como passar um drink no cardapio diario...
//TODO: Criar model que definde o cardapio do dia( o model final, mais importante para o home) ???

//TODO: Quantidade dos extras (Ex: brocolis 2 unidades)
//TODO: Implement 'unidade de medida' nos extras comumente usada(Tentar limitar a quantidade)

//TODO: Terminar de preencher com base nos quadros de categoria do livro
enum FoodCategory {
  drink,
  meat,
  vegetable,
  fruit,
}

class FoodModel {
  String title;
  String img;
  String desc;
  //enum
  FoodCategory category;

  //TODO: Add PE

  FoodModel({
    this.title,
    this.img,
    this.desc,
    this.category,
  });

  // List<CookingType> getCooking(int i) {
  //   return i.toString().split("").map((String c) => CookingType.values[int.parse(c)]).toList();
  // }

  // List<MealType> getMeal(int i) {
  //   return i.toString().split("").map((String c) => MealType.values[int.parse(c)]).toList();
  // }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FoodModel && o.title == title && o.img == img && o.desc == desc;
  }

  @override
  int get hashCode => title.hashCode ^ img.hashCode ^ desc.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'img': img,
      'desc': desc,
      'category': category?.index,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FoodModel(
      title: map['title'],
      img: map['img'],
      desc: map['desc'],
      category: FoodCategory.values[map['category']],
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(title: $title, img: $img, desc: $desc, category: $category)';
  }

  static getCategoryFromIndex(int index) => FoodCategory.values[index];
  static getIndexFromCategory(FoodCategory category) => category.index;
}

/*

  static String unidadeToString(UnidadeType u, int a) {
    switch (u) {
      case UnidadeType.colher:
        return (a > 1) ? 'colheres' : 'colher';
      case UnidadeType.copo:
        return (a > 1) ? 'copos' : 'copo';
      case UnidadeType.porcao:
        return (a > 1) ? 'porções' : 'porção';
      case UnidadeType.unidade:
        return (a > 1) ? 'unidades' : 'unidade';
      case UnidadeType.xicara:
        return (a > 1) ? 'xícaras' : 'xícara';
      default:
        return null;
    }
  }
}

enum UnidadeType {
  porcao,
  unidade,
  colher,
  xicara,
  copo,
}
*/
