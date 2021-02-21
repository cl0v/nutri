import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/repositories/question_repository.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/constants.dart';

class QuestionsController extends GetxController {
  final UserPreferencesRepository userDataRepository;
  final QuestionRepository questionRepository;
  QuestionsController({
    this.userDataRepository,
    @required this.questionRepository,
  });

  PageController _pageController = PageController();

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
    _setQuestionList();
  }

  _setQuestionList() async {
    _questions.assignAll(await questionRepository.loadQuestionList());
  }

//TODO: BUGFIX: Se eu clickar rapido, a pagination pode pular mais de uma pagina(2x click)
//TODO: O Questions deve receber a altura e peso do cliente
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
    userDataRepository.setQuestionsPrefs(ans);
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
