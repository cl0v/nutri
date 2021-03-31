import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

class ReviewCardViewModel {
  final ILocalStorage storage;

  ReviewCardViewModel({
    required this.storage,
  });

  final _reviewKey = 'reviewListKey';
  String get reviewKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_reviewKey';


  Future<List<ReviewCardModel>> fetchReviewList() async {
    List<dynamic> json = await storage.get(reviewKey) ?? [];
    return json.map((e) => ReviewCardModel.fromJson(e)).toList();
  }

  Future<void> setReview(MealModel overviewModel, bool done) async { 
    List<ReviewCardModel> reviewList = await fetchReviewList();
    ReviewCardModel reviewModel = ReviewCardModel.fromMealModel(overviewModel, done);
    reviewList.add(reviewModel);
    List<String> list = reviewList.map((e) => e.toJson()).toList();
    storage.put(reviewKey, list);
  }
}
