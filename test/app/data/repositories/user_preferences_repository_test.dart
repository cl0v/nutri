import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/providers/user_preferences_provider.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  UserPreferencesRepository repository = UserPreferencesRepository(
    provider: UserPreferencesProvider(
      sharedPreferences: SharedPreferences.getInstance(),
    ),
  );
  test(
    'Testing food rating pref getFoodPrefs() with no value',
    () async {
      var result = await repository.getFoodPrefs();
      expect(result, {});
    },
  );
  test(
    'Testing food rating prefs',
    () async {
      repository.setFoodsPrefs(map);
      var result = await repository.getFoodPrefs();
      expect(result, map);
    },
  );
}

var map = {
  'frango': 5,
  'ovos': 4,
  'cafe': 3,
  'cha': 2,
  'soda': 1,
};

// setFoodsPrefs
// getFoodPrefs
