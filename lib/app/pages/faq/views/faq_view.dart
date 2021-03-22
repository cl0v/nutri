import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perguntas frequentes'),
          centerTitle: true,
        ),
        body: Obx(
          () => controller.faqList.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.faqList.length,
                  itemBuilder: (ctx, idx) => Obx(()=>ExpansionTile(
                    title: Text(controller.faqList[idx].question),
                    // subtitle: Text('Sei la mano'),
                    childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    children: [
                      Text(controller.faqList[idx].answer, textAlign: TextAlign.center,),
                    ],
                  ),)
                )
              : Container(),
        ));
  }
}
