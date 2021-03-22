import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:get/get.dart';

class ReviewViewModel {
  final reviewList = <ReviewModel>[].obs;

  init(List<OverviewModel> overList, List<bool> doneList) async {
    //TODO: Remover esses caras do inicializador, receber por banco de dados
    var list = <ReviewModel>[];
    overList.forEach((element) {
      var idx = overList.indexOf(element);
      list.add(ReviewModel(overviewModel: element, isDone: doneList[idx]));
    });
    reviewList.assignAll(list);
  }
}
