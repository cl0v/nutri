import 'package:nutri/app/models/diet_model.dart';

abstract class IDiet {
  Future<DietModel> getBreakfast(int day);
  Future<DietModel> getLunch(int day);
  Future<DietModel> getSnack(int day);
  Future<DietModel> getDinner(int day);
}
