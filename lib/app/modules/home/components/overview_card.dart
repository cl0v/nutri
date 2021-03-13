import 'package:flutter/material.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';
import 'package:nutri/constants.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({required this.items});
  
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (ct, idx) {
          if (idx == 0) return Text('Refeições do dia:', style: TextStyle(color: Colors.white, fontSize: 32,),textAlign: TextAlign.center,);//Refeições do dia
          return AspectRatio(
            aspectRatio: 2.9,
            child: FoodCard(
              image: items[idx - 1]['image']!,
              title: items[idx - 1]['title']!,
            ),
          );
        },
      ),
    );
  }
}
