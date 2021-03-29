import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/home_diet_viewmodel.dart';

class ReviewViewModel {
  final reviewList = <ReviewModel>[].obs;

  final HomeDietViewModel homeDietViewModel; //TODO: Rename in bindings

  ReviewViewModel({
    required this.homeDietViewModel,
  });

  init() async {
    reviewList.assignAll(await homeDietViewModel.getReviewList());
  }
}
