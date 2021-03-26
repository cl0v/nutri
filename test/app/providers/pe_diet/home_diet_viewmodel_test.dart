import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_diet_viewmodel.dart';
import 'package:nutri/app/providers/pe_diet/default_pe_diet_provider.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final ILocalStorage localStorage = SharedLocalStorageService();
  final IDiet diet = DefaultPeDietProvider();
  final HomeDietViewModel defaultPeDietRepository =
      HomeDietViewModel(storage: localStorage, diet: diet);
  group('Overview sucess |', () {
    Future<List> future = defaultPeDietRepository.getOverviewList(1);
    test('length should be always 4', () async {
      var list = await future;
      expect(list.length, equals(4));
    });
    test('Overview meal shoul be 0 to 3 in order', () async {
      var list = (await future).map((e) => e.type.index).toList();
      expect(list, equals([0, 1, 2, 3]));
    });

    test('Overview meal shoul be Breakfast to Dinner in order', () async {
      var list = (await future).map((e) => e.type).toList();
      expect(
          list,
          containsAllInOrder([
            MealType.breakfast,
            MealType.lunch,
            MealType.snack,
            MealType.dinner,
          ]));
    });

    test('Overview should be a future of list of MealModel', () async {
      expect(future, isA<Future<List<MealModel>>>());
    });
  });

  group('Overview error |', () {
    test('day 0 should throw exception', () {
      expect(() async => await defaultPeDietRepository.getOverviewList(0),
          throwsException);
    });
    test('day 0 should throw exception', () {
      expect(() async => await defaultPeDietRepository.getOverviewList(8),
          throwsException);
    });
  });

  group('Review sucess', () {});
}
