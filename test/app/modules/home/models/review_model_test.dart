import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

main() {
  test('Testing review model from json', () {
    var review = ReviewCardModel.fromMap(map);
    expect(review.img, equals('img'));
  });

  test('Testing review to map', () {
    var review = ReviewCardModel.fromMap(map);
    expect(review.toMap(), equals(map));
  });
}

const map = {
  'type': 0,
  'img': 'img',
  'isDone': true,
};
