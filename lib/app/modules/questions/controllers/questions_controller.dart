import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nutri/constants.dart';

class QuestionsController extends GetxController {
  final UserPreferencesRepository userDataRepository;
  QuestionsController({
    this.userDataRepository,
  });

  PageController _pageController;

  PageController get pageController => this._pageController;

  RxList<Question> _questions = <Question>[].obs;

  List<Question> get questions => this._questions;

  var _isAnswered = false.obs;
  bool get isAnswered => _isAnswered.value;

  final _index = RxInt();
  int get index => this._index.value;

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
    // _questions.assignAll(sample_data
    //     .map(
    //       (question) => Question(
    //         pref: question['pref'],
    //         question: question['question'],
    //         options: question['options'],
    //       ),
    //     )
    //     .toList());
    setQuestionList();
  }

  setQuestionList() async {
    _questions.assignAll(await loadQuestionList()) ;
    print(_questions);
  }

//TODO: Se eu clickar rapido, a pagination pode pular mais de uma pagina(2x click)
  Future<List<Question>> loadQuestionList() async {
    var data = await loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => Question.fromMap(e)).toList();
  }

  loadJson() async {
    return await rootBundle.loadString('assets/jsons/questions.json');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _pageController.dispose();
  }

  onSkipPressed() {
    Get.offAndToNamed(Routes.FOOD_SWIPE);
  }

  Map<String, String> _answers = {};

  onAnswerTapped(Question question, int index) {
    _answers[question.pref] = question.options[index];
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
