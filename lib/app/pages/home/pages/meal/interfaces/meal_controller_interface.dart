import '../meal_card_model.dart';

abstract class IMealController {
  late MealCardModel mealCardModel;
  void onMainFoodTapped(int idx);
  void onExtraFoodTapped(int idx); //TODO: Ajustar para ja receber a lista
  void onDonePressed();
  void onSkipPressed();
}
