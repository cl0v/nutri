import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/questions/components/question_card.dart';
import 'package:nutri/app/modules/questions/components/question_options.dart';
import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:nutri/constants.dart';

//TODO: Escurecer a letra das respostas do question (Sugestao mae)
//TODO: Testar essa página

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
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text.rich(
                TextSpan(
                  text:
                      "Por favor, me ajude a te entender melhor", //TODO: Pensar no papel desse titulo, pois ele pode ser removido
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: kSecondaryColor),
                ),
              ),
            ),
          ),
          Divider(thickness: 1.5),
          SizedBox(height: kDefaultPadding),
          Expanded(
            flex: 7,
            child: Obx(
              () => PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                itemCount: controller.questions.length,
                onPageChanged: controller.onQuestionPageChanged,
                itemBuilder: (context, qidx) => QuestionCard(
                  children: [
                    Center(
                      child: Text(
                        controller.questions[qidx].question,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: kBlackColor),
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    ...List.generate(
                      controller.questions[qidx].options.length,
                      (oidx) {
                        var option = controller.questions[qidx].options[oidx];
                        return Obx(
                          () => QuestionOption(
                            isSelected: controller.selectedIndex ==
                                controller.getOptionIndex(
                                  qidx,
                                  option,
                                ),
                            text: option,
                            onTap: () =>
                                controller.onAnswerTapped(qidx, option),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

// 1 item question card em que os filhos sao textfiel
// os itens seguintes sao quest com opções
