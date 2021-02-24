import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/modules/questions/components/question_card_options.dart';
import 'package:nutri/constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
<<<<<<< HEAD
    @required this.children,
  });

  final List<Widget> children;
=======
    // @required this.questionModel,
    @required this.question,
    @required this.options,
    // this.onTap,
  });

  // final QuestionModel questionModel;
  final String question;
  final List<Widget> options;
  // final Function(QuestionModel, int) onTap;
>>>>>>> parent of d2dbd33 (Alterações de melhorias na question page)

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
