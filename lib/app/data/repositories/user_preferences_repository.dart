import 'package:meta/meta.dart';
import 'package:nutri/app/data/providers/user_preferences_provider.dart';

class UserPreferencesRepository {
  final UserPreferencesProvider provider;

  UserPreferencesRepository({@required this.provider});

  void setQuestionsPrefs(Map<String, String> answers) =>
      provider.setQuestionsPrefs(answers);

  Future<Map<String, String>> getQuestionsPrefs() =>
      provider.getQuestionsPrefs();

  void setFoodsPrefs(Map<String, int> foodPref) =>
      provider.setFoodsPrefs(foodPref);
      
  Future<Map<String, int>> getFoodPrefs() => provider.getFoodsPrefs();
}
