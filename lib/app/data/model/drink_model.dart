class DrinkModel {
  String title;
  String img;
  String desc;

  DrinkModel({this.title, this.img, this.desc});

  DrinkModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    img = json['img'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['img'] = this.img;
    data['desc'] = this.desc;
    return data;
  }
}
