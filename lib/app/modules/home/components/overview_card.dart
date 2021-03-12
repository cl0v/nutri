import 'package:flutter/material.dart';

class OverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Container(
      child: Column(
        children: [
          Card(
            child: Text('Suas refeições do dia são'),
          ),
        ],
      ),),
    );
  }
}
