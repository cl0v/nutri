import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutri/app/models/food_model.dart';

class FirestoreFoodModel extends FoodModel {
  final DocumentReference reference;
  FirestoreFoodModel({
    required FoodModel food,
    required this.reference,
  }) : super(
          category: food.category,
          img: food.img,
          title: food.title,
        );

  factory FirestoreFoodModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return FirestoreFoodModel(
      food: FoodModel.fromMap(snapshot.data()!),
      reference: snapshot.reference,
    );
  }
}
