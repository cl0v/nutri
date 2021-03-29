import 'package:flutter/material.dart';

class HomeTitleBarWidget extends StatelessWidget {
  final Function() onPreviewDayPressed;
  final Function() onNextDayPressed;
  final String title;
  final bool isPreviewBtnDisabled;
  final bool isNextBtnDisabled;

  HomeTitleBarWidget({
    required this.onPreviewDayPressed,
    required this.onNextDayPressed,
    required this.title,
    required this.isPreviewBtnDisabled,
    required this.isNextBtnDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: isPreviewBtnDisabled ? null : onPreviewDayPressed,
        ),
        Text(title),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: isNextBtnDisabled ? null :  onNextDayPressed,
        ),
      ],
    );
  }
}
