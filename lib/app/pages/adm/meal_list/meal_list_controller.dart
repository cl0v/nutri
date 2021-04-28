import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:nutri/app/models/firestore/firestore_meal_model.dart';
import 'package:nutri/app/models/meal_model.dart';

class MealListController extends GetxController {
  RxList<FirestoreMealModel> mealList = <FirestoreMealModel>[].obs;
  final firestore = FirebaseFirestore.instance.collection('meals');
  // FirestoreMealRepository mealRepository = FirestoreMealRepository();

  @override
  void onReady() async {
    super.onReady();
    mealList.assignAll(await fetchMeal());
  }

  onDeleteMealPressed(FirestoreMealModel meal) async{
    await meal.reference.delete();
  }

  onAddMealPressed(){}

  Future<List<FirestoreMealModel>> fetchMeal() async {
    var query = await firestore.get();
    return query.docs
        .map((doc) => FirestoreMealModel.fromDocumentSnapshot(doc))
        .toList();
  }
}
