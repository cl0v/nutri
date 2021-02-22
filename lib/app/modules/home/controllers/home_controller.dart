import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

//TODO: Quando a pessoa nao tem extras ou terminou as refeicoes do dia, mostra os card de agua??
//TODO: Resetar os extras marcados e manter salvo quando a pessoa terminar;
//--- Provavelmente vou ter que criar um model só pra salvar qual a comida, o estado da comida(concluido ou skipado), quais extras foram mostrados(not needed yet) e quais foram marcados....
class HomeController extends GetxController {
  final MealRepository mealRepository;

  HomeController({@required this.mealRepository});

  final _meals = <MealCardModel>[].obs;
  List<MealCardModel> get meals => _meals;

  final _extras = <FoodModel>[].obs;
  List<FoodModel> get extras => _extras;

  final _mealIndex = 0.obs;
  //TODO: Selecionar quais index ficaram ativos(Manter estado)

  final _selectedExtrasList = <int>[].obs;

  CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    _fetchMeals();
    ever(_mealIndex, onMealChanged);
  }

  onMealChanged(i) {
    _selectedExtrasList.clear();
    _updateMeal(meals[i]);
  }

  _fetchMeals() async {
    _meals.assignAll((await mealRepository.fetchMeals())
        .map((meal) => MealCardModel(mealModel: meal))
        .toList());
    _mealIndex.value = 0;
  }

  ///Responsável por qualquer atualização na pagina com base no index do carroussel
  _updateMeal(MealCardModel m) => _extras.assignAll(m.mealModel.extras);

  getSelectedIndex(int idx) {
    if (_selectedExtrasList.contains(idx)) {
      return true;
    }
    return false;
  }

  onExtraTapped(int idx) {
    if (!_selectedExtrasList.contains(idx) &&
        _selectedExtrasList.length <
            3) //TODO: selecionar aqui a quantidade de acompanhamentos
      _selectedExtrasList.add(idx);
    else
      _selectedExtrasList.remove(idx);
  }

//TODO: CHECK: IMPORTANT: Quando chega no ultimo item, nao tem pra onde ir, o app trava
//TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
//TODO: BUG: O primeiro item nao está colorindo
//TODO: BUG: onDonePressed Error: The getter 'iterator' was called on null.

  //TODO: Atualizar assim que marcado

  onDonePressed() {
    meals[_mealIndex.value].mealCardState = MealCardState.Done;
    _nextMeal();
  }

  onSkipPressed() {
    meals[_mealIndex.value].mealCardState = MealCardState.Skiped;
    _nextMeal();
  }

  onPageChanged(int index, CarouselPageChangedReason reason) =>
      _mealIndex.value = index;

  //TODO: Error quando termina e aperta em concluir
  //RangeError (index): Invalid value: Not in inclusive range 0..10: 12

  //TODO: So está atualizando quando a lista termina
  //TODO: Fazer algo quando conclui o ultimo item

  _nextMeal() => carouselController.nextPage();

  onChangePressed() {
    //TODO: Implement onChangePressed
    // int idx = mealList.indexOf(mealCard) + 1;
    // mealCard.value.mealCardState = MealCardState.Done;
    // if (idx < mealList.length)
    //   _updateExtraList(mealList[idx].value.mealModel.extras);
    // carouselController.nextPage();
  }
}
