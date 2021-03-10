import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

//IDEIA: Informar ao usuario a quantidade mínima que deve ser selecionada
// -- Talvez colocar o contador no botao de confirmar 'Confirmar(3)' > Confirmar(2)...

class FoodSwipeController extends GetxController {
  final FoodSwipeRepository repository;

  FoodSwipeController({
    this.repository,
  });

  List<FoodSwipeModel> _foodSwipeList = <FoodSwipeModel>[];
  Rx<FoodSwipeModel> _currentFoodSwipeModel = FoodSwipeModel().obs;
  FoodSwipeModel get currentFoodSwipeModel => _currentFoodSwipeModel.value;

  List<String> _foodPrefs = <String>[];
  var _checkedIndexes = <int>[].obs;

  int currentIndex = 0;

  final _isConfirmBtnAvailable = false.obs;
  bool get isConfirmBtnAvailable => _isConfirmBtnAvailable.value;

  final _amountSelected = 0.obs;
  int get amountSelected => _amountSelected.value;

  PageController pageController = PageController(viewportFraction: 0.8);

  final _isReady = false.obs;
  bool get isOkey => _isReady.value;

  @override
  void onInit() {
    super.onInit();
    _fetchFoodSwipeList();
  }

  onReadyPressed() => _isReady.value = true;

  onConfirmPressed() async {
    ++currentIndex;
    if (currentIndex == _foodSwipeList.length) 
      _savePrefs().whenComplete(() => Get.offAllNamed(Routes.HOME));
     else {
      _setShowingFoodSwipe(_foodSwipeList[currentIndex]);
      _isConfirmBtnAvailable.value = false; // Passar isso pra um metodo
      _amountSelected.value = 0;
      pageController.jumpToPage(0);
      _checkedIndexes.clear();
    }
  }

  void onCheckTapped(FoodModel food, int index) {
    if (isChecked(index)) {
      _amountSelected.value--;
      _checkedIndexes.remove(index);
      _foodPrefs.remove(food.title);
    } else if (amountSelected < currentFoodSwipeModel.maximum) {
      _amountSelected.value++;
      _checkedIndexes.add(index);
      _foodPrefs.add(food.title);
    }
    if (currentFoodSwipeModel.minimum <= _amountSelected.value) {
      _isConfirmBtnAvailable.value = true;
    }
  }

  bool isChecked(int index) => _checkedIndexes.contains(index);

  Future _savePrefs() async => await repository.setFoodPreferences(_foodPrefs);

  _setShowingFoodSwipe(FoodSwipeModel fSwipeModel) {
    _currentFoodSwipeModel.value = fSwipeModel;
  }

  _fetchFoodSwipeList() async {
    _foodSwipeList = await repository.loadFoodSwipeList();
    _setShowingFoodSwipe(_foodSwipeList.first);
  }
}
