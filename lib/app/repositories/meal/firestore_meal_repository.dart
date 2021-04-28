import 'dart:math';

import 'package:nutri/app/interfaces/providers/meal_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//TODO: Definir algo mais especifico, como o dia, para ordenar por dia
//TODO: Definir o dia e o mes que aquele prato aparecerá, para ter mais controle e ter mais pratos disponíveis

class FirestoreMealRepository implements IMealRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<MealModel> fetchMealByType(MealType type) async {
    var query = await firestore
        .collection('meals')
        .where('type', isEqualTo: type.index)
        .get();
    return query.docs
        .map((doc) => MealModel.fromMap(doc.data()))
        .toList()[Random().nextInt(query.docs.length)];
  }
}
