import 'dart:convert';


class UserModel {
  final String name;
  final int weight; //kg
  final int height; //cm
  final int age; 
  //enum
  final Goal goal;
  //enum
  final Intensity intensity; //TODO: Remover tudo daqui e passar para as prefs
  final bool diabetes;
  final bool medications;
  final bool hypertensive;
  final bool hypotensive;
  
  UserModel({
    this.goal,
    this.intensity,
    this.diabetes,
    this.medications,
    this.hypertensive,
    this.hypotensive,
    this.name,
    this.weight,
    this.age,
    this.height,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
      'height': height,
      'age': age,
      'goal': goal,
      'intensity': intensity,
      'diabetes': diabetes,
      'medications': medications,
      'hypertensive': hypertensive,
      'hypotensive': hypotensive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      name: map['name'],
      weight: map['weight'],
      height: map['height'],
      age: map['age'],
      goal: map['goal'],
      intensity: map['intensity'],
      diabetes: map['diabetes'],
      medications: map['medications'],
      hypertensive: map['hypertensive'],
      hypotensive: map['hypotensive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}

var mockedUser = {
  'name': 'marcelo',
  'age': 19,
  'height': 184,
  'weight': 78,
  'goal': Goal.Manter,
  'intensity': Intensity.PoucoIntenso,
  'diabetes': false,
  'medications': false,
  'hypertensive': false,
  'hypotensive': false,
};

enum Goal { Perder, Manter, Ganhar }
enum Intensity { Sedentario, PoucoIntenso, Intenso, Atletico }
