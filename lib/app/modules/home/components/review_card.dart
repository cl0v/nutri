import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Container(
      child: Column(
        children: [
          Card(child: Text('Voce fez x pontos'),)
        ],
      ),),
    );
  }
}