
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:nutri/app/models/meal_model.dart';

class FirestoreMealModel extends MealModel {
  final DocumentReference reference;
  FirestoreMealModel({
    required MealModel meal,
    required this.reference,
  }) : super(
          img: meal.img,
          title: meal.title,
          type: meal.type,
        );

  factory FirestoreMealModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return FirestoreMealModel(
        meal: MealModel.fromMap(snapshot.data()!),
        reference: snapshot.reference);
  }
}
