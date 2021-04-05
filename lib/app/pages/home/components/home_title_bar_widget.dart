import 'package:flutter/material.dart';

class HomeTitleBarWidget extends StatelessWidget {
  final Function() onPreviewDayPressed;
  final Function() onNextDayPressed;
  final String title;
  final bool isPreviewBtnEnabled;
  final bool isNextBtnEnabled;

  HomeTitleBarWidget({
    required this.onPreviewDayPressed,
    required this.onNextDayPressed,
    required this.title,
    required this.isPreviewBtnEnabled,
    required this.isNextBtnEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: isPreviewBtnEnabled ? onPreviewDayPressed : null,
        ),
        Text(title),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: isNextBtnEnabled ? onNextDayPressed : null,
        ),
      ],
    );
  }
}
