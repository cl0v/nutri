import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';

class HomeReviewViewController {
  final ReviewViewModel reviewViewModel;

  HomeReviewViewController({required this.reviewViewModel});
  List<ReviewModel> get reviewList => reviewViewModel.reviewList;

}