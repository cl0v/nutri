import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/questions/components/question_card.dart';
import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:nutri/constants.dart';

class QuestionViewBody extends StatelessWidget {
  const QuestionViewBody({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final QuestionsController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text.rich(
              TextSpan(
                text: "Por favor, me ajude a te entender melhor",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: kSecondaryColor),
              ),
            ),
          ),
          Divider(thickness: 1.5),
          // SizedBox(height: kDefaultPadding),
          Expanded(
            child: Obx(() => PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    onTap: controller.onAnswerTapped,
                    question: controller.questions[index],
                  ),
                )),
          ),
          SizedBox(height: kDefaultPadding * 3),
        ],
      ),
    );
  }
}
