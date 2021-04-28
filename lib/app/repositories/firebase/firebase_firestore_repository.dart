import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutri/app/interfaces/repositories/server_storage_interface.dart';

class FirebaseFirestoreRepository implements IServerStorage {
  FirebaseFirestore firestore = FirebaseFirestore.instance; //Injeta

  @override
  Future create(String collectionPath, Map<String, dynamic> data) async {
    return firestore.collection(collectionPath).add(data);
  }

  @override
  delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  getCollection(String collectionPath) {
    return firestore.collection(collectionPath);
  }

  @override
  update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
/*
Future<List<FoodModel>> loadFoodList(FoodCategory category) async {
    var query = await firestore
        .collection('foods')
        .where('category', isEqualTo: category.index)
        .limit(9)
        .get();

    return query.docs.map((doc) => FoodModel.fromMap(doc.data())).toList();
  }
*/
/*
Future<MealModel> fetchMealByType(MealType type) async {
    var query = await firestore
        .collection('meals')
        .where('type', isEqualTo: type.index)
        .get();
    return query.docs
        .map((doc) => MealModel.fromMap(doc.data()))
        .toList()[Random().nextInt(query.docs.length)];
  }
*/