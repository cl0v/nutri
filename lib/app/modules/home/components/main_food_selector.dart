import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';

// Quando escolher, esconde as opçoes e aparece uma pequena seta para expandir
//IDEIA: Quando seleciona ele esconde, e vira uma setinha que quando clica ele expande novamente

//FIXME: Não está intuitivo o suficiente que é para tocar em alguma das comidas

class FoodSelector extends StatefulWidget {
  final List<FoodModel> foodList;
  final Function(int) onTap;

  FoodSelector({
    required this.foodList,
    required this.onTap,
  });

  @override
  _FoodSelectorState createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector> {
  var selectedIndex = 0;

  onTap(int idx) {
    widget.onTap(idx);
    setState(() {
      selectedIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.foodList.length > 1
            ? Text(
                'Selecione uma opção', //Tornar isso dinamico (multiplas opções)
                style: TextStyle(color: Colors.white),
              )
            : Container(),
        AspectRatio(
          aspectRatio: 5,
          child: widget.foodList.length > 1
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: widget.foodList.map((f) {
                    var idx = widget.foodList.indexOf(f);
                    return Expanded(
                      child: MainFoodSelectableCard(
                        food: f,
                        onTap: () => onTap(idx),
                        selected: idx == selectedIndex,
                      ),
                    );
                  }).toList())
              : Container(),
        ),
      ],
    );
  }
}



class MainFoodSelectableCard extends StatelessWidget {
  final FoodModel food;
  final Function onTap;
  final bool? selected;

  MainFoodSelectableCard({
    required this.food,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(
              food.img,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selected!
                ? Colors.green.withOpacity(.4)
                : Colors.black.withOpacity(.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                food.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
