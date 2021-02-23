import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/questions/components/question_card.dart';
import 'package:nutri/app/modules/questions/components/question_options.dart';
import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:nutri/constants.dart';

//TODO: Escurecer a letra das respostas do question (Sugestao mae)

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
                  itemCount: controller.questions.length + 1,
                  onPageChanged: controller.onQuestionChanged,
                  itemBuilder: (context, index) {
                    if (index == 0)
                      return QuestionCard(
                        question: 'Informe os valores',
                        buttonOn: true,
                        options: [
                          TextField(),
                          TextField(),
                          
                        ],
                      );

                    return QuestionCard(
                      question: controller.questions[index - 1].question,
                      options: controller.questions[index - 1].options
                          .map(
                            (option) => Obx(
                              () => QuestionOption(
                                isSelected: controller.selectedIndex ==
                                    controller.getOptionIndex(
                                        index - 1, option),
                                text: option,
                                // getColor: controller.getColor(),
                                onTap: () => controller.onAnswerTapped(
                                    index - 1, option),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  }),
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
