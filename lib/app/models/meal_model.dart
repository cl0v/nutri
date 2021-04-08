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
  final String title;
  //FoodCategory foodCategoryRequired
  //FoodCategory extraFoodCategoryRequired

  MealModel({
    required this.type,
    required this.img,
    required this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'img': img,
      'title': title,
    };
  }

  MealModel.fromMap(Map<String, dynamic> map)
      : this.type = MealType.values[map['type']],
      this.title = map['title'],
        this.img = map['img'];

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MealModel && other.type == type && other.img == img;
  }

  @override
  int get hashCode => type.hashCode ^ img.hashCode;

}
