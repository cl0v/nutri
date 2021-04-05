import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/review_card_viewmodel.dart';

class HomeReviewController {
  //DONE: Revisar
  IReviewCardVM reviewViewModel;

  HomeReviewController({required this.reviewViewModel,});

  final _reviewList = <ReviewCardModel>[].obs;

  List<ReviewCardModel> get reviewList => _reviewList;
  
  void init() async {
    _reviewList.assignAll(await reviewViewModel.fetchReviewList());
  }

  Future<void> setReview(MealModel m, bool d) =>
      reviewViewModel.setReview(m, d);

}
