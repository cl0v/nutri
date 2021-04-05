import 'dart:convert';

enum MealType {
  breakfast,
  lunch,
  snack,
  dinner,
}

class MealModel {
  //enum
  final MealType type;
  final String img;
  final int day;
  //TODO: Adicionar o titulo da refeição e mostrar no lugar de qual refeição será(Proxima minor update)
  //FoodCategory foodCategoryRequired
  //FoodCategory extraFoodCategoryRequired

  MealModel({
    required this.type,
    required this.img,
    this.day = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'img': img,
      'day': day,
    };
  }

  MealModel.fromMap(Map<String, dynamic> map)
      : this.type = MealType.values[map['type']],
        this.img = map['img'],
        this.day = map['day'];

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(json.decode(source));

  String mealTypeToString() {
    switch (type) {
      case MealType.breakfast:
        return "Café da manhã";
      case MealType.lunch:
        return "Almoço";
      case MealType.snack:
        return "Lanche";
      case MealType.dinner:
        return "Jantar";
      default:
        return '';
    }
  }
}
