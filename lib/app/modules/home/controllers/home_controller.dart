import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

class HomeController extends GetxController {
  final MealRepository mealRepository;

  HomeController({@required this.mealRepository});

  RxList<Rx<MealCardModel>> _mealList = <Rx<MealCardModel>>[].obs;
  List<Rx<MealCardModel>> get mealList => _mealList;

  CarouselController carouselController = CarouselController();

  RxList<ExtraModel> _extraList = <ExtraModel>[].obs;
  List<ExtraModel> get extraList => _extraList;

  @override
  void onInit() {
    super.onInit();
    _fetchMeals();
  }

  _fetchMeals() async {
    _mealList.assignAll((await mealRepository.fetchMeals(4))
        .map(
          (meal) =>
              MealCardModel(mealModel: meal, mealCardState: MealCardState.None)
                  .obs,
        )
        .toList());
    _updateExtraList(_mealList.first.value.mealModel.extras);
  }

  _updateExtraList(List<ExtraModel> list) {
    //TODO: BUG: Quando a pessoa rola sem apertar o botao, os extras nao atualizam
    //TODO: Quando a pessoa nao tem extras ou terminou as refeicoes do dia, mostra os card de agua??
    _extraList.assignAll(list);
  }

  final _isSelected = false.obs;
  bool get isSelected => _isSelected.value;

  final _index = 0.obs;
  int get index => _index.value;

  final _selectedExtrasList = <int>[].obs;

  getSelectedIndex(int idx) {
    if (_selectedExtrasList.contains(idx)) {
      return true;
    }
    return false;
  }

  onExtraTapped(int idx) {
    if (!_selectedExtrasList.contains(idx) && _selectedExtrasList.length < 3)
      _selectedExtrasList.add(idx);
    else
      _selectedExtrasList.remove(idx);
  }

//TODO: CHECK: IMPORTANT: Quando chega no ultimo item, nao tem pra onde ir, o app trava
//TODO:  Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)

  onDonePressed(Rx<MealCardModel> mealCard) {
    mealCard.value.mealCardState = MealCardState.Done;
     _changeValues(mealCard);
  }

  _changeValues(Rx<MealCardModel> mealCard) {
    //TODO: Rename
    int idx = mealList.indexOf(mealCard) + 1;
    if (idx < mealList.length)
      _updateExtraList(mealList[idx].value.mealModel.extras);
    //TODO: So está atualizando quando a lista termina
    //TODO: Fazer algo quando conclui o ultimo item
    carouselController.nextPage();
  }

  onSkipPressed(Rx<MealCardModel> mealCard) {
    mealCard.value.mealCardState = MealCardState.Skiped;
    _changeValues(mealCard);
  }

  onChangePressed(Rx<MealCardModel> mealCard) {
    // int idx = mealList.indexOf(mealCard) + 1;
    // mealCard.value.mealCardState = MealCardState.Done;
    // if (idx < mealList.length)
    //   _updateExtraList(mealList[idx].value.mealModel.extras);
    // //TODO: So está atualizando quando a lista termina
    // //TODO: Fazer algo quando conclui o ultimo item
    // carouselController.nextPage();
  }

  onInfoPressed() {
    //TODO: Implement on card info pressed
  }
  // @override
  // void onReady() {}

  // @override
  // void onClose() {}

}
