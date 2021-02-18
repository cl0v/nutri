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
}

