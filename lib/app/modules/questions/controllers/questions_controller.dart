import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/routes/app_pages.dart';

class QuestionsController extends GetxController {
  PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _questions = sample_data
      .map(
        (question) => Question(
            id: question['id'],
            question: question['question'],
            options: question['options'],
            answer: question['answer_index']),
      )
      .toList();

  List<Question> get questions => this._questions;

  var isAnswered = false.obs;

  int _index;
  int get index => this._index;

  @override
  void onInit() {
    super.onInit();
    _pageController = PageController();
  }

//Pegar o index da resposta e fazer o card ficar colorido
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

  checkAns(Question question, int index) {
    isAnswered.value = true;
    _index = index;
    update();

    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  nextQuestion() {
    if (pageController.page.round() != questions.length - 1) {
      isAnswered.value = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 250), curve: Curves.ease);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
