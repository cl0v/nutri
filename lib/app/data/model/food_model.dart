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

  // List<CookingType> getCooking(int i) {
  //   return i.toString().split("").map((String c) => CookingType.values[int.parse(c)]).toList();
  // }
  
  // List<MealType> getMeal(int i) {
  //   return i.toString().split("").map((String c) => MealType.values[int.parse(c)]).toList();
  // }


  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is FoodModel &&
      o.title == title &&
      o.prefs == prefs &&
      o.img == img &&
      o.desc == desc;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      prefs.hashCode ^
      img.hashCode ^
      desc.hashCode;
  }
}

enum CookingType {
  grelhado,
  assado,
  cozido,
  frito,
}
