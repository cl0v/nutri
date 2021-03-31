import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

abstract class IReviewCardVM {
  Future<List<ReviewCardModel>> fetchReviewList();
  Future<void> setReview(MealModel meal, bool done);
}
