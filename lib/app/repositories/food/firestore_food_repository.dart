import 'package:nutri/app/interfaces/providers/food_interface.dart';
import 'package:nutri/app/interfaces/repositories/server_storage_interface.dart';
import 'package:nutri/app/models/food_model.dart';

class FirestoreFoodRepository implements IFoodRepository {
  final IServerStorage serverStorage;

  FirestoreFoodRepository({required this.serverStorage});

  @override
  Future<List<FoodModel>> loadFoodList(FoodCategory category) async {
    var query = await serverStorage
        .getCollection('foods')
        .where('category', isEqualTo: category.index)
        .limit(9)
        .get();

    return query.docs.map((doc) => FoodModel.fromMap(doc.data())).toList();
  }
}
