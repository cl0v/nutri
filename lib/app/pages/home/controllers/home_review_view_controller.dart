import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';

class HomeReviewViewController {
   ReviewViewModel reviewViewModel;

  HomeReviewViewController({required this.reviewViewModel});


  List<ReviewModel> get reviewList => reviewViewModel.reviewList;
  Future<void> setReview(MealModel m, bool d) =>
      reviewViewModel.setReview(m, d);

  void init() => reviewViewModel.init();
}
