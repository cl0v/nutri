import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';

// Quando escolher, esconde as opçoes e aparece uma pequena seta para expandir
//IDEIA: Quando seleciona ele esconde, e vira uma setinha que quando clica ele expande novamente

//FIXME: Não está intuitivo o suficiente que é para tocar em alguma das comidas

class MainFoodSelectorWidget extends StatefulWidget {
  final List<FoodModel> foodList;

  MainFoodSelectorWidget({
    required this.foodList,
  });

  @override
  _MainFoodSelectorWidgetState createState() => _MainFoodSelectorWidgetState();
}

class _MainFoodSelectorWidgetState extends State<MainFoodSelectorWidget> {
  var _selectedIndex = 0;

  // final controller = Get.find<HomeController>();
  onTap(int idx) {
    // controller.onMainFoodTapped(idx);
    setState(() {
      _selectedIndex = idx;
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
                      child: FoodSelectableCardWidget(
                        food: f,
                        onTap: () => onTap(idx),
                        selected: idx == _selectedIndex,
                      ),
                    );
                  }).toList())
              : Container(),
        ),
      ],
    );
  }
}

class FoodSelectableCardWidget extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;
  final bool? selected;

  FoodSelectableCardWidget({
    required this.food,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
