import 'package:flutter/material.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';

class OverviewCard extends StatelessWidget {
  final List<Map<String, String>> items;

  const OverviewCard({required this.items});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (ct, idx) {
          if (idx == 0) return Text('Refeições de hoje', style: TextStyle(color: Colors.white, fontSize: 32,),textAlign: TextAlign.center,);
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
