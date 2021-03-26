import 'dart:convert';

enum FoodCategory {
  none,
  drink,
  meat,
  vegetable,
  lowSugarFruits,
  tuber,
  eggs,
  nuts,
  dairy,
  mushroom,
  fruits,
  others,
}

enum MainOrExtra {
  main,
  extra,
  both,
}

class FoodModel {
  String title;
  String img;
  // String? desc;
  //enum
  FoodCategory category;
  //enum
  MainOrExtra mainOrExtra;


  FoodModel({
    required this.title,
    required this.img,
    // this.desc,
    required this.category,
    required this.mainOrExtra,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'img': img,
      // 'desc': desc,
      'category': category.index,
      'mainOrExtra': mainOrExtra.index,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) => FoodModel(
        title: map['title'],
        img: map['img'],
        // desc: map['desc'],
        category: FoodCategory.values[map['category']],
        mainOrExtra: MainOrExtra.values[map['mainOrExtra']],
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'FoodModel(title: $title)';
  }

  int get categoryIndex => category.index;
  static getIndexFromCategory(FoodCategory category) => category.index;
}
