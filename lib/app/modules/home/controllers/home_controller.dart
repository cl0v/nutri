import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';

class HomeController extends GetxController {
  final MealRepository mealRepository;

  HomeController({@required this.mealRepository});

  RxList<MealModel> _mealList = <MealModel>[].obs;
  List<MealModel> get mealList => _mealList;

  CarouselController carouselController = CarouselController();

  RxList<ExtraModel> _extraList = <ExtraModel>[].obs;
  List<ExtraModel> get extraList => _extraList;
// TODO: Receber a lista de extras por reatividade

  @override
  void onInit() {
    super.onInit();
    _fetchMeals();
  }

  //TODO: Implementar para fazer com que a meal seja uma lista de acompanhamentos + a comida principal
  _fetchMeals() async {
    //TODO: Implement _fetchMeals()
    _mealList.assignAll(await mealRepository.loadMeals());
    _updateExtraList(_mealList.first.extras);
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
    //TODO: Criar update no cardapio final(no icone i e na logica do calculo de proteinas);
  }

//TODO: Quando chega no ultimo item, nao tem pra onde ir, o app trava

  onDonePressed(MealModel meal) {
    //TODO: Implement onDonePressed
    int idx = mealList.indexOf(meal) + 1;
    // if (mealList.length - 1 > idx) {
    if (idx < mealList.length) _updateExtraList(mealList[idx].extras);

    // }
    //Posso desativar o botao de concluido
    //TODO: Fazer algo quando conclui o ultimo item
    carouselController.nextPage();
  }

  onInfoPressed() {
    //TODO: Implement on card info pressed
  }
  // @override
  // void onReady() {}

  // @override
  // void onClose() {}

}

List<FoodModel> fList = [
  FoodModel(
    img:
        'https://i.pinimg.com/474x/e2/fe/5c/e2fe5c199feb50e474ce4f2c98c5274b.jpg',
    // texto: 'Café da manhã',

    title: 'Café preto',
  ),
  FoodModel(
    img:
        'https://i.pinimg.com/564x/e0/d1/08/e0d108f2b18bc168edc824bfab8399a2.jpg',
    // texto: 'Almoço',
    title: 'Peito de frango',
  ),
  FoodModel(
    img:
        'https://i.pinimg.com/474x/de/58/f7/de58f749a33fb02aca97492b35e73382.jpg',
    // texto: 'Jantar',
    title: 'Carne com brocolis',
  ),
];

/*
  var extras = <ExtraCardModel>[
    ExtraCardModel(food: fList[1], amount: 2, unidade: UnidadeType.unidade),
    ExtraCardModel(food: fList[0], amount: 1, unidade: UnidadeType.xicara),
    ExtraCardModel(food: fList[2], amount: 3, unidade: UnidadeType.porcao),
    ExtraCardModel(food: fList[1], amount: 2, unidade: UnidadeType.unidade),
    ExtraCardModel(food: fList[0], amount: 1, unidade: UnidadeType.xicara),
    ExtraCardModel(food: fList[2], amount: 3, unidade: UnidadeType.porcao),
    ExtraCardModel(food: fList[1], amount: 2, unidade: UnidadeType.unidade),
    ExtraCardModel(food: fList[0], amount: 1, unidade: UnidadeType.xicara),
    ExtraCardModel(food: fList[2], amount: 3, unidade: UnidadeType.porcao),
  ];
*/
