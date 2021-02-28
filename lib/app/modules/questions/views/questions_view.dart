import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:nutri/app/modules/questions/views/questions_body.dart';

class QuestionsView extends GetView<QuestionsController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/Profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              FlatButton(
                  onPressed: controller.onSkipPressed, child: Text('Pular'))
            ],
          ),
          body: QuestionViewBody(controller: controller),
        ),
      ],
    );
  }
}
