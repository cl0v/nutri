import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutri/constants.dart';

const questionsJson = 'assets/jsons/questions.json';

class QuestionsController extends GetxController {
  final UserPreferencesRepository userDataRepository;
  QuestionsController({
    this.userDataRepository,
  });

  PageController _pageController;

  PageController get pageController => this._pageController;

  RxList<QuestionModel> _questions = <QuestionModel>[].obs;

  List<QuestionModel> get questions => this._questions;

  var _isAnswered = false.obs;
  bool get isAnswered => _isAnswered.value;

  final _index = RxInt();
  int get index => this._index.value;

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
    setQuestionList();
  }

  setQuestionList() async {
    _questions.assignAll(await loadQuestionList());
  }

//TODO: Se eu clickar rapido, a pagination pode pular mais de uma pagina(2x click)
  Future<List<QuestionModel>> loadQuestionList() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
  }

  _loadJson() async {
    return await rootBundle.loadString(questionsJson);
  }

  @override
  void onClose() {
    _pageController.dispose();
  }

  onSkipPressed() {
    Get.offAndToNamed(Routes.FOOD_SWIPE);
  }

  Map<String, String> _answers = {};

  onAnswerTapped(QuestionModel question, int index) {
    _answers[question.prefs] = question.options[index];
    _isAnswered.value = true;
    _index.value = index;

    Future.delayed(Duration(seconds: 1), () {
      _nextQuestion();
    });
  }

  _saveAnswers(Map ans) {
    userDataRepository.setUserInfo(ans);
  }

  Color getTheRightColor(idx) {
    if (isAnswered) {
      if (idx == this.index) return kGreenColor;
    }
    return kGrayColor;
  }

  _nextQuestion() {
    if (pageController.page.round() != questions.length - 1) {
      _isAnswered.value = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      _saveAnswers(_answers);
      Get.offAllNamed(Routes.FOOD_SWIPE);
    }
  }
}
