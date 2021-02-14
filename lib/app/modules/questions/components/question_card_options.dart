import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:nutri/constants.dart';

class Option extends StatelessWidget {
  Option({
    Key key,
    this.text,
    this.index,
    this.onTap,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback onTap;

  final controller = Get.find<QuestionsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(top: kDefaultPadding),
            padding: EdgeInsets.all(kDefaultPadding),
            decoration: BoxDecoration(
              border: Border.all(color: controller.getTheRightColor(index)),
              borderRadius: BorderRadius.circular(15),
              // color: kGreenColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${index + 1}. $text",
                  style: TextStyle(
                      color: controller.getTheRightColor(index), fontSize: 16),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: controller.getTheRightColor(index) == kGrayColor
                        ? Colors.transparent
                        : controller.getTheRightColor(index),
                    borderRadius: BorderRadius.circular(50),
                    border:
                        Border.all(color: controller.getTheRightColor(index)),
                  ),
                  child: controller.getTheRightColor(index) == kGrayColor
                      ? null
                      : Icon(Icons.done, size: 16),
                )
              ],
            ),
          ),
        ));

    // return GetBuilder<QuestionsController>(
    //     init: QuestionsController(),
    //     builder: (controller) {
    //       return InkWell(
    //         onTap: onTap,
    //         child: Container(
    //           margin: EdgeInsets.only(top: kDefaultPadding),
    //           padding: EdgeInsets.all(kDefaultPadding),
    //           decoration: BoxDecoration(
    //             border: Border.all(color: controller.getTheRightColor(index)),
    //             borderRadius: BorderRadius.circular(15),
    //             // color: kGreenColor
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 "${index + 1}. $text",
    //                 style: TextStyle(color: controller.getTheRightColor(index), fontSize: 16),
    //               ),
    //               Container(
    //                 height: 26,
    //                 width: 26,
    //                 decoration: BoxDecoration(
    //                   color: controller.getTheRightColor(index) == kGrayColor
    //                       ? Colors.transparent
    //                       : controller.getTheRightColor(index),
    //                   borderRadius: BorderRadius.circular(50),
    //                   border: Border.all(color: controller.getTheRightColor(index)),
    //                 ),
    //                 child: controller.getTheRightColor(index) == kGrayColor
    //                     ? null
    //                     : Icon(Icons.done, size: 16),
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }
}
