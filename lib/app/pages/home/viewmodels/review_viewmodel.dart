import 'package:nutri/app/interfaces/repositories/pe_diet_interface.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:get/get.dart';

class ReviewViewModel {
  final reviewList = <ReviewModel>[].obs;

  final IPeDiet repository;

  ReviewViewModel({
    required this.repository,
  });

  init() async {
    reviewList.assignAll(await repository.getReviewList());
  }
}
