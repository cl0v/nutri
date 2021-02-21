import 'dart:convert';

class FoodModel {
  String title;
  String img;
  String desc;
  //TODO: Add PE

  FoodModel({
    this.title,
    this.img,
    this.desc,
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
  
    return o is FoodModel &&
      o.title == title &&
      o.img == img &&
      o.desc == desc;
  }

  @override
  int get hashCode => title.hashCode ^ img.hashCode ^ desc.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'img': img,
      'desc': desc,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return FoodModel(
      title: map['title'],
      img: map['img'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) => FoodModel.fromMap(json.decode(source));
}

