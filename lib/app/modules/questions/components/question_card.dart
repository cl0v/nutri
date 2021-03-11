import 'package:flutter/material.dart';
import 'package:nutri/constants.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.children,
  });

  final List<Widget> children;

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
