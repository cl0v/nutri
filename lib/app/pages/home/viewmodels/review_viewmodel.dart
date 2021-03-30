import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:get/get.dart';

class ReviewViewModel {
  final reviewList = <ReviewModel>[].obs;

  final ILocalStorage storage;

  ReviewViewModel({
    required this.storage,
    
  });

  final _reviewKey = 'reviewListKey';
  String get reviewKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_reviewKey';

  init() async {
    reviewList.assignAll(await _fetchReviewList());
  }

  Future<List<ReviewModel>> _fetchReviewList() async {
    List<dynamic> json = await storage.get(reviewKey) ?? [];
    return json.map((e) => ReviewModel.fromJson(e)).toList();
  }

  Future<void> setReview(MealModel overviewModel, bool done) async { //TODO: Esse cara so esta sendo usado na home_menu
    List<ReviewModel> reviewList = await _fetchReviewList();
    ReviewModel reviewModel = ReviewModel.fromMealModel(overviewModel, done);
    reviewList.add(reviewModel);
    List<String> list = [];
    list.addAll(reviewList.map((e) => e.toJson()));

    storage.put(reviewKey, list);
  }
}
