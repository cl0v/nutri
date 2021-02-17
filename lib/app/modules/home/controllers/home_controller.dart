import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/extras_model.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

class HomeController extends GetxController {
  RxList<MealModel> _mealList = <MealModel>[].obs;
  List<MealModel> get mealList => _mealList;

// TODO: Receber a lista de extras por reatividade

  List<FoodModel> foodList = fList;

  var extras = <ExtraModel>[
    ExtraModel(food: fList[1], amount: 2, unidade: 'unidades'),
    ExtraModel(food: fList[0], amount: 1, unidade: 'chícara'),
    ExtraModel(food: fList[2], amount: 3, unidade: 'porções'),
    ExtraModel(food: fList[0], amount: 1, unidade: 'chícara'),
    ExtraModel(food: fList[2], amount: 3, unidade: 'porções'),
    ExtraModel(food: fList[1], amount: 2, unidade: 'unidades'),
    ExtraModel(food: fList[2], amount: 3, unidade: 'porções'),
    ExtraModel(food: fList[1], amount: 2, unidade: 'unidades'),
    ExtraModel(food: fList[0], amount: 1, unidade: 'chícara'),
  ];

  final FoodRepository foodRepository;

  HomeController({@required this.foodRepository});

  CarouselController c = CarouselController();

  @override
  void onInit() {
    super.onInit();
    _fetchFoodList();
  }

  _fetchFoodList() async {
    _mealList.assignAll(await foodRepository.loadMeals());
  }

  _fetchMeal() {
    //TODO: Implementar para fazer com que a meal seja uma lista de acompanhamentos + a comida principal
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

  onExtraTapped(ExtraModel extra, int idx) {
    if (!_selectedExtrasList.contains(idx) && _selectedExtrasList.length < 3)
      _selectedExtrasList.add(idx);
    else
      _selectedExtrasList.remove(idx);
    print(_selectedExtrasList);
    //TODO: Criar update no cardapio final(no icone i e na logica do calculo de proteinas);
  }

  onDonePressed() {
    //TODO: Implement onDonePressed
    c.nextPage();
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
