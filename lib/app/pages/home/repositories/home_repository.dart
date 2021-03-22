import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/models/old_menu_model.dart';
import 'package:nutri/app/pages/home/providers/home_provider.dart';

class HomeRepository {
  final HomeProvider provider;

  HomeRepository({
    required this.provider,
  });

  getMeals({int day = 1}) => provider.getMeals(day: day);

  Future<List<OverviewModel>> getOverViewListFromPEDietSugestion() =>
      provider.getOverViewListFromPEDietSugestion(); //TODO: Remover
  Future<List<OldMenuModel>> getMenuListFromPEDietSugestion() => provider.getMenuListFromPEDietSugestion();//TODO: Remover

  String getDayTitle({int day = 1}) => provider.getDayTitle(day: day);

  Future<List<List<OldMenuModel>>> fetchDailyMenuOfTheWeek() =>
      provider.fetchMealsOfTheWeek();

  // Stream<HomeState> getHomeState() => provider.getHomeState();

  closeHomeStream() => provider.closeHomeStream();

  Future<List<OldMenuModel>> fetchDailyMeals() => provider.fetchDailyMeals();

  Future<int> getPageIndex() => provider.getPageIndexFromPrefs();
  void setPageIndex(int pageIdx) => provider.setPageIndexOnPrefs(pageIdx);

  Future<List<String>> getMealsCard() => provider.getMealsCard();
  saveMealCard(String mealType, String s) => provider.saveMealCard(mealType, s);

  // Future saveMealPrefs(String mealType, List<String> list) =>
  // provider.saveMealPrefs(mealType, list);
}
