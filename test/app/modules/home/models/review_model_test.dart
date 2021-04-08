import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/models/home_meal_review.dart';

main() {
  test('Testing review model from json', () {
    var review = HomeMealReviewModel.fromMap(map);
    expect(review.img, equals('img'));
  });

  test('Testing review to map', () {
    var review = HomeMealReviewModel.fromMap(map);
    expect(review.toMap(), equals(map));
  });
}

const map = {
  'type': 0,
  'img': 'img',
  'isDone': true,
};
