import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

//TODO: Quando a pessoa nao tem extras ou terminou as refeicoes do dia, mostra os card de agua??
//TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
//TODO: IDEIA: Depois que o user conclui a ultima refeição, dar a possibilidade de ver o que vai comer amanha (desativar os botoes de concluir e pular... Deixar apenas o trocar)

//TODO: Atualizar a cor do card assim que marcado
//TODO: Definir a quantidade de acompanhamentos (inicialmente 3 [extrasAmount])

//--- Provavelmente vou ter que criar um model só pra salvar qual a comida, o estado da comida(concluido ou skipado), quais extras foram mostrados(not needed yet) e quais foram marcados....
class HomeController extends GetxController {
  final MealRepository mealRepository;

  HomeController({@required this.mealRepository});

  final _meals = <MealCardModel>[].obs;
  List<MealCardModel> get meals => _meals;

  final _extras = <FoodModel>[].obs;
  List<FoodModel> get extras => _extras;

  ///Armazena o index do atual meal card
  final _mealIndex = 0.obs;
  int get mealIndex => _mealIndex.value;

  ///Armazena os extras selecionados do atual meal card
  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  ///Quantidade de extras que deverá ter
  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  CarouselController carouselController = CarouselController();

  @override
  void onInit() {
    super.onInit();
    _fetchMeals();
    ever(_mealIndex, _onMealChanged);
  }

  onPageChanged(int index, CarouselPageChangedReason reason) {
    _saveExtrasSelectedIndex();
    _mealIndex.value = index;
  }
  // if (index >= meals.length - 1) print('Ultimo aq'); 

  _onMealChanged(index) {
    _setExtras();
  }

  _setExtras() {
    _selectedExtrasList.assignAll(meals[mealIndex].extrasSelectedIndex);
    _extras.assignAll(meals[mealIndex].mealModel.extras);
  }

  _saveExtrasSelectedIndex() {
    meals[_mealIndex.value].extrasSelectedIndex = _selectedExtrasList.toList();
    _selectedExtrasList.clear();
  }

  getSelectedIndex(int idx) => _selectedExtrasList.contains(idx);

  onExtraTapped(int idx) => !_selectedExtrasList.contains(idx) &&
          _selectedExtrasList.length < extrasAmount
      ? _selectedExtrasList.add(idx)
      : _selectedExtrasList.remove(idx);

  onDonePressed() {
    meals[_mealIndex.value].mealCardState = MealCardState.Done;
    _nextMeal();
  }

  onSkipPressed() {
    meals[_mealIndex.value].mealCardState = MealCardState.Skiped;
    _nextMeal();
  }

  _nextMeal() => carouselController.nextPage();

  _fetchMeals() async {
    _meals.assignAll((await mealRepository.fetchMeals())
        .map((meal) => MealCardModel(mealModel: meal))
        .toList());
    _mealIndex.value = 0;
  }

  onChangePressed() {
    //TODO: Implement onChangePressed
    // int idx = mealList.indexOf(mealCard) + 1;
    // mealCard.value.mealCardState = MealCardState.Done;
    // if (idx < mealList.length)
    //   _updateExtraList(mealList[idx].value.mealModel.extras);
    // carouselController.nextPage();
  }
}
