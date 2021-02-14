import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/repositories/user_data_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class QuestionsController extends GetxController {
  final UserDataRepository userDataRepository;
  QuestionsController({
    this.userDataRepository,
  });

  PageController _pageController;

  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            pref: question['pref'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => this._questions;

  var _isAnswered = false.obs;
  bool get isAnswered => _isAnswered.value;

  int _index;
  int get index => this._index;

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
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
    _index = index;
    update();

    Future.delayed(Duration(seconds: 1), () {
      _nextQuestion();
    });
  }

  _saveAnswers(Map ans) {
    userDataRepository.setUserInfo(ans);
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
