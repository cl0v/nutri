import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/home_meal_review.dart';


abstract class IReviewCardSetter{
Future<void> setReview(MealModel meal, bool done);
}

abstract class IReviewCardVM implements IReviewCardSetter{
  Future<List<HomeMealReviewModel>> fetchReviewList();
}

final _reviewKey = 'reviewListKey';

class ReviewCardViewModel implements IReviewCardVM {
  final ILocalStorage storage;

  ReviewCardViewModel({
    required this.storage,
  });

  String get reviewKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_reviewKey';

  Future<List<HomeMealReviewModel>> fetchReviewList() async {
    List<dynamic> json = await storage.get(_reviewKey) ?? [];
    return json.map((e) => HomeMealReviewModel.fromJson(e)).toList();
  }

  Future<void> setReview(MealModel overviewModel, bool done) async {
    List<HomeMealReviewModel> reviewList = await fetchReviewList();
    HomeMealReviewModel reviewModel =
        HomeMealReviewModel.fromMealModel(overviewModel, done);
    reviewList.add(reviewModel);
    List<String> list = reviewList.map((e) => e.toJson()).toList();
    storage.put(_reviewKey, list);
  }
}
