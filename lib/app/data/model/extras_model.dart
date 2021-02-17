import 'package:nutri/app/data/model/food_model.dart';

class ExtraModel {
  final FoodModel food;
  final int amount; //Provavelmente trocar
  final UnidadeType unidade;

  ExtraModel({
    this.food,
    this.amount,
    this.unidade,
  });

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
