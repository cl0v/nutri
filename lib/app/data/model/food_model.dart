class FoodModel {
  String title;
  String prefs;
  String img;
  List<String> cooking;
  List<String> meal;
  Nutrition nutrition;

  FoodModel({
    this.title,
    this.prefs,
    this.img,
    this.cooking,
    this.meal,
    this.nutrition,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    prefs = json['prefs'];
    img = json['img'];
    cooking = json['cooking'].cast<String>();
    meal = json['meal'].cast<String>();
    nutrition = json['nutrition'] != null
        ? new Nutrition.fromJson(json['nutrition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['prefs'] = this.prefs;
    data['img'] = this.img;
    data['cooking'] = this.cooking;
    data['meal'] = this.meal;
    if (this.nutrition != null) {
      data['nutrition'] = this.nutrition.toJson();
    }
    return data;
  }
}

class Nutrition {
  double calories;
  double carbohydrate;
  double fiber;
  double fat;
  double protein;

  Nutrition(
      {this.calories, this.carbohydrate, this.fiber, this.fat, this.protein});

  Nutrition.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbohydrate = json['carbohydrate'];
    fiber = json['fiber'];
    fat = json['fat'];
    protein = json['protein'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['carbohydrate'] = this.carbohydrate;
    data['fiber'] = this.fiber;
    data['fat'] = this.fat;
    data['protein'] = this.protein;
    return data;
  }
}
