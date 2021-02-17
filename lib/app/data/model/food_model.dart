class FoodModel {
  String title;
  String prefs;
  String img;
  String desc;
  //TODO: Add PE
  //enum
  // List<CookingType> cooking;
  //enum
  // List<MealType> meal;

  FoodModel({
    this.title,
    this.prefs,
    this.img,
    this.desc,
    // this.cooking,
    // this.meal,
  });

  FoodModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    prefs = json['prefs'];
    img = json['img'];
    desc = json['desc'];
    // cooking = getCooking(json['cooking']); //TODO: Esse cara é um int -> enum
    // meal = getMeal(json['meal']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['prefs'] = this.prefs;
    data['img'] = this.img;
    data['desc'] = this.desc;
    // data['cooking'] = this.cooking;
    // data['meal'] = this.meal;
    return data;
  }

  List<CookingType> getCooking(int i) {
    return i.toString().split("").map((String c) => CookingType.values[int.parse(c)]).toList();
  }
  
  List<MealType> getMeal(int i) {
    return i.toString().split("").map((String c) => MealType.values[int.parse(c)]).toList();
  }

}

enum MealType {
  breakfast,
  brunch,
  elevenses,
  lunch,
  tea,
  supper,
  dinner,
}

enum CookingType {
  grelhado,
  assado,
  cozido,
  frito,
}
