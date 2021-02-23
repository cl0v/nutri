import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

//TODO: Quando a pessoa nao tem extras ou terminou as refeicoes do dia, mostra os card de agua??
//TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
//TODO: Criar um card para o final da lista(Card indicando os pontos da pessoa e talvez um pequeno resuminho)
//TODO: Pode ser um card chapado azul da cor do tema, apenas um overview do dia;
//TODO: IDEIA: Depois que o user conclui a ultima refeição, dar a possibilidade de ver o que vai comer amanha (desativar os botoes de concluir e pular... Deixar apenas o trocar)

//TODO: Atualizar a cor do card assim que marcado (Está com um delay de 1 aparentemente...)
//TODO: Definir a quantidade de acompanhamentos (inicialmente 3 [extrasAmount])

//TODO: IDEIA: Add dots indicator : https://github.com/jlouage/flutter-carousel-pro/blob/master/lib/src/carousel_pro.dart
//TODO: A rolagem está tendo um efeito estranho, como se fosse recriado depois de ja ter percorrido uma parte do caminho

//TODO: Bloquear seleção de extras quando ja tiver concluido a refeição
//--- Provavelmente vou ter que criar um model só pra salvar qual a comida, o estado da comida(concluido ou skipado), quais extras foram mostrados(not needed yet) e quais foram marcados....
class HomeController extends GetxController {
  final MealRepository mealRepository;

  HomeController({@required this.mealRepository});

  List<MealCardModel> mealList = <MealCardModel>[];
  final mealListLenght = 0.obs;

  final _extras = <FoodModel>[].obs;
  List<FoodModel> get extras => _extras;

  ///Armazena o index do atual meal card
  int mealIndex = 0;

  ///Armazena os extras selecionados do atual meal card
  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  ///Quantidade de extras que deverá ter
  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _fetchMeals();
  }

  onPageChanged(int idx) {
    //TODO: Indicador de qual página está agora (as bolinhas no cantinho)
    _saveExtrasSelectedIndex();
    mealIndex = idx;
    _onMealChanged(idx);
  }

  _onMealChanged(int idx) {
    _setExtras(idx);
  }

  _setExtras(int idx) {
    _selectedExtrasList.assignAll(mealList[idx].extrasSelectedIndex);
    _extras.assignAll(mealList[idx].mealModel.extras);
  }

  _saveExtrasSelectedIndex() {
    mealList[mealIndex].extrasSelectedIndex = _selectedExtrasList.toList();
    _selectedExtrasList.clear();
  }

  getSelectedIndex(int idx) => _selectedExtrasList.contains(idx);

  onExtraTapped(int idx) => !_selectedExtrasList.contains(idx) &&
          _selectedExtrasList.length < extrasAmount
      ? _selectedExtrasList.add(idx)
      : _selectedExtrasList.remove(idx);

  onDonePressed(int idx) {
    mealList[idx].mealCardState = MealCardState.Done;
    _nextMeal(idx);
  }

  onSkipPressed(int idx) {
    mealList[idx].mealCardState = MealCardState.Skiped;
    _nextMeal(idx);
  }

  _nextMeal(int idx) {
    if (idx >= mealListLenght.value - 1) {
      pageController.jumpToPage(0);
    } else
      pageController.nextPage(
          duration: Duration(milliseconds: 1), curve: Curves.linear);
  }

  _fetchMeals() async {
    mealList = ((await mealRepository.fetchMeals())
        .map((meal) => MealCardModel(mealModel: meal))
        .toList());
    mealListLenght.value = mealList.length;
    _onMealChanged(0);
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
