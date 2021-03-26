import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

main() {
  test('Testing review model from json', () {
    var review = ReviewModel.fromMap(map);
    expect(review.meal.img, equals('img'));
  });
}

final map = {
  'type': 0,
  'img': 'img',
  'day': 1,
  'isDone': true,
};
