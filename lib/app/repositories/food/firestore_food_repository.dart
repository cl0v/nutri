import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutri/app/interfaces/providers/food_interface.dart';
import 'package:nutri/app/models/food_model.dart';

class FirestoreFoodRepository implements IFoodRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<FoodModel>> loadFoodList(FoodCategory category) async {
    var query = await firestore
        .collection('foods')
        .where('category', isEqualTo: category.index)
        .limit(9)
        .get();

    return query.docs.map((doc) => FoodModel.fromMap(doc.data())).toList();
  }
}
