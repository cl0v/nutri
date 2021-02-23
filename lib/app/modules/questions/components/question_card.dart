import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/modules/questions/components/question_card_options.dart';
import 'package:nutri/constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    // @required this.questionModel,
    @required this.question,
    @required this.options,
    // this.onTap,
  });

  // final QuestionModel questionModel;
  final String question;
  final List<Widget> options;
  // final Function(QuestionModel, int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView(
        children: [
          Center(
            child: Text(
              question,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: kBlackColor),
            ),
          ),
          SizedBox(height: kDefaultPadding / 2),
          ...List.generate(
            options.length,
            (index) => options[index],
          ),
        ],
      ),
    );
  }
}
