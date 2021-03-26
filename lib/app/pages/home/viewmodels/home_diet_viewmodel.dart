import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

class HomeDietViewModel {
  final ILocalStorage storage;
  final IDiet diet;

  HomeDietViewModel({
    required this.storage,
    required this.diet,
  });

  final _reviewKey = 'reviewListKey';
  String get reviewKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_reviewKey';

  Future<List<MenuModel>> getMenuList(int day) async {
    if (day < 1) throw Exception('Dia não pode ser menor que 1');
    if (day > 7) throw Exception('Dia não pode ser maior que 7');
    return [
      MenuModel.fromDietModel((await diet.getBreakfast(day))),
      MenuModel.fromDietModel((await diet.getLunch(day))),
      MenuModel.fromDietModel((await diet.getSnack(day))),
      MenuModel.fromDietModel((await diet.getDinner(day))),
    ];
  }

  Future<List<MealModel>> getOverviewList(int day) async {
    if (day < 1) throw Exception('Dia não pode ser menor que 1');
    if (day > 7) throw Exception('Dia não pode ser maior que 7');
    return [
      (await diet.getBreakfast(day)).meal,
      (await diet.getLunch(day)).meal,
      (await diet.getSnack(day)).meal,
      (await diet.getDinner(day)).meal,
    ];
  }

  Future<List<ReviewModel>> getReviewList() async {
    List<dynamic> json = await storage.get(reviewKey) ?? [];
    //FIXME: Ta rolando um bug quando fica nulo, mudei a chave
    return json.map((e) => ReviewModel.fromJson(e)).toList();
  }

  Future setReview(MealModel overviewModel, bool done) async {
    List<ReviewModel> reviewList = await getReviewList();
    ReviewModel reviewModel = ReviewModel(meal: overviewModel, done: done);
    reviewList.add(reviewModel);
    List<String> list = [];
    list.addAll(reviewList.map((e) => e.toJson()));

    storage.put(reviewKey, list);
  }
}
