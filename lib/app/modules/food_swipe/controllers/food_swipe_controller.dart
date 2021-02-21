import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';
import 'package:nutri/app/data/repositories/food_preferences_repository.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class FoodSwipeController extends GetxController {
  final FoodPreferencesRepository foodPreferencesRepository;
  final FoodRepository foodRepository;

  final FoodSwipeRepository foodSwipeRepository =
      FoodSwipeRepository(foodSwipeProvider: FoodSwipeProvider());

  FoodSwipeController({
    this.foodPreferencesRepository,
    @required this.foodRepository,
  });

  RxList<FoodModel> _foodList = <FoodModel>[].obs;
  List<FoodModel> get foodList => _foodList;

  List<FoodSwipeModel> _foodSwipeList = <FoodSwipeModel>[];
  Rx<FoodSwipeModel> _showingFoodSwipeModel = FoodSwipeModel().obs;
  FoodSwipeModel get showingFoodSwipeModel => _showingFoodSwipeModel.value;

  PageController pageController;
  final _currentPageValue = 0.0.obs;
  double get currentPageValue => _currentPageValue.value;

  final _isOkey = false.obs;
  bool get isOkey => _isOkey.value;

  @override
  void onInit() {
    //TODO: Tornar o food swipe uma pagina que será acessada varias vezes por fontes
    //TODO: Informar o que está sendo escolhido(Cafe da manha, almoço, etc)
    //TODO: Informar para quando está sendo escolhido(HOJE, SEMANA)
    //TODO: BUG: Caso eu vire o card e arraste para duas cartas na frente, o estado do primeiro se perde e volta a parte frontal da carta
    //TODO: Checkar se está vindo de algum lugar com o arguments, se estiver nulo ou vazio, mostrar a primeira pagina
    super.onInit();
    _fetchFoodsAvailable();
    _fetchSomethingToSwipe();
    pageController = PageController(viewportFraction: 0.8)
      ..addListener(
        () {
          _currentPageValue.value = pageController.page;
        },
      );
  }

  _fetchSomethingToSwipe() async {
    // TODO: Receber a origem do swipe
    // if (Get.arguments)
    //   return //TODO: Estou travando para que quando venha de outras origens nao carregue as comidas
    //TODO: _fetchSomethingToSwipe.....
    _foodSwipeList = await foodSwipeRepository.loadFoodSwipeList();
    _setShowingFoodSwipe(_foodSwipeList.first);
  }

  _setShowingFoodSwipe(FoodSwipeModel foodSwipeModel) =>
      _showingFoodSwipeModel.value = foodSwipeModel;

  onSkipPressed() {
    Get.offAllNamed(Routes.HOME);
    //TODO: Pular a categoria *Proximo foodSwipe
    //TODO: Caso seja a ultima, salvar e ir pra home
  }

  List<String> _foodPrefs = <String>[];
  var _checkedIndexes = <int>[].obs;

  void onCheckTapped(FoodModel food, int index) {
    if (isChecked(index)) {
      _checkedIndexes.remove(index);
      _foodPrefs.remove(food.title);
    } else {
      _checkedIndexes.add(index);
      _foodPrefs.add(food.title);
    }
  }

  onConfirmPressed() {
    //TODO: Implement onConfirmPressed
    _savePrefs();
    Get.offAllNamed(Routes.HOME);
    //TODO: Pular a categoria *Proximo foodSwipe
    //TODO: Caso seja a ultima, salvar e ir pra home
  }

  void _savePrefs() {
    foodPreferencesRepository.setFoodsPrefs(_foodPrefs);
  }

  bool isChecked(int index) {
    return _checkedIndexes.contains(index);
  }

  onBuildCardapioPressed() {
    _isOkey.value = true;
  }

  _fetchFoodsAvailable() async {
    _foodList.assignAll(await foodRepository.loadAllFoods());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
