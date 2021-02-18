import 'package:meta/meta.dart';
import 'package:nutri/app/data/providers/user_preferences_provider.dart';

class UserPreferencesRepository {
  final UserPreferencesProvider provider;

  UserPreferencesRepository({@required this.provider});

  void setQuestionsPrefs(Map<String, String> answers) =>
      provider.setQuestionsPrefs(answers);

  Future<Map<String, String>> getQuestionsPrefs() =>
      provider.getQuestionsPrefs();


//TODO: Passar para o food_prefs_repository.dart
  void setFoodsPrefs(Map<String, int> foodPref) =>
      provider.setFoodsPrefs(foodPref);
      
  getFoodPrefs() => provider.getFoodsPrefs();
}
