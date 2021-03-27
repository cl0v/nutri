import 'package:nutri/app/interfaces/providers/pe_diet_interface.dart';
import 'package:nutri/app/models/diet_model.dart';

class CarnivorePeDietRepository implements IPeDiet{
  CarnivorePeDietRepository();

  @override
  Future<DietModel> getBreakfast(int day) {
    // TODO: implement getBreakfast
    throw UnimplementedError();
  }

  @override
  Future<DietModel> getDinner(int day) {
    // TODO: implement getDinner
    throw UnimplementedError();
  }

  @override
  Future<DietModel> getLunch(int day) {
    // TODO: implement getLunch
    throw UnimplementedError();
  }

  @override
  Future<DietModel> getSnack(int day) {
    // TODO: implement getSnack
    throw UnimplementedError();
  }

}
