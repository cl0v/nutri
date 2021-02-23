import 'package:flutter/material.dart';
import 'package:nutri/constants.dart';

class QuestionOption extends StatelessWidget {
  QuestionOption({
    this.text,
    this.isSelected,
    this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  

  @override
  Widget build(BuildContext context) {


  Color getColor = (isSelected ? kGreenColor : kGrayColor);


    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          border: Border.all(color: getColor),
          borderRadius: BorderRadius.circular(15),
          // color: kGreenColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$text",
              style: TextStyle(color: getColor, fontSize: 16),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: getColor == kGrayColor
                    ? Colors.transparent
                    : getColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getColor),
              ),
              child: getColor == kGrayColor
                  ? null
                  : Icon(Icons.done, size: 16),
            )
          ],
        ),
      ),
    );
  }
}
