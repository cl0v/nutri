
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key key,
    @required this.scale,
    this.items,
    this.index,
  }) : super(key: key);

  final double scale;
  final int index;
  final List items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(items[index]['image']),
          fit: BoxFit.cover,
        ),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 30 - 30 * scale,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  items[index]['title'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  items[index]['text'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}