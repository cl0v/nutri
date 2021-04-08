import 'package:nutri/app/models/diet_model.dart';

enum HomeCardStatus{
  Skipped,
  Done,
  None,
}

class HomeCardModel extends DietModel {
  bool isDone = false; //TODO: Alterar para homecardStatus
  HomeCardModel(meal, this.isDone) : super(meal: meal);
}
