import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/repositories/question_repository.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

//TODO: O Questions deve receber a altura e peso do cliente

//BUG: Se eu clickar rapido, a pagination pode pular mais de uma pagina(2x click)

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

  RxInt _selectedIndex = 5.obs;
  int get selectedIndex => _selectedIndex.value;

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

  onQuestionChanged(int idx){
    lockedAnswer = false;
  }

  @override
  void onClose() {
    _pageController.dispose();
  }

  onSkipPressed() {
    Get.offAndToNamed(Routes.FOOD_SWIPE);
  }

  Map<String, String> _answers = {};
  var indexDaOpcao = -1;


  int getOptionIndex(int qIdx, String opt) =>
      questions[qIdx].options.indexOf(opt);

  bool lockedAnswer = false;
  onAnswerTapped(int qIdx, String opt) {
    if (lockedAnswer) return;
    lockedAnswer = true;
    _selectedIndex.value = questions[qIdx].options.indexOf(opt);
    //se o index for a mesma que a questao, marca saporra
    // selectedIndex = idx;
    // _answers[question.prefs] = question.options[index];
    // _isSelectedQ.value = selectedIndex == questions[qIdx].options.indexOf(opt);
    _isAnswered.value = true;
    _index.value = index;

//Receber o index da pagina, vai saber qual questao está sendo gerada
//Receber o index da opçao marcada vai saber qual opçao deve ter qual cor
    Future.delayed(Duration(milliseconds: 500), () {
      _nextQuestion();
    });
  }

  _saveAnswers(Map ans) {
    userDataRepository.setQuestionsPrefs(ans);
  }

  _nextQuestion() {
    if (pageController.page.round() != questions.length - 1) {
      _selectedIndex.value = -1;
      _isAnswered.value = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      _saveAnswers(_answers);
      Get.offAllNamed(Routes.FOOD_SWIPE);
    }
  }
}
