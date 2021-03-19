import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/components/food_selectable_card.dart';

// Quando escolher, esconde as opçoes e aparece uma pequena seta para expandir
//IDEIA: Quando seleciona ele esconde, e vira uma setinha que quando clica ele expande novamente

//FIXME: Não está intuitivo o suficiente que é para tocar em alguma das comidas

class MainFoodSelector extends StatelessWidget {

  final String selectedFoodImg;
  final String selectedFoodTitle;
  final List<FoodModel> foods;
  final Function(int) onTap;
  final bool Function(int) isSelected;

  MainFoodSelector({
    required this.selectedFoodImg,
    required this.selectedFoodTitle,
    required this.foods,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.2,
          child: FoodCard(
            image: selectedFoodImg,
            title: selectedFoodTitle,
          ),
        ),
        foods.length > 1
            ? Text(
                'Selecione uma opção',
                style: TextStyle(color: Colors.white),
              )
            : Container(),
        AspectRatio(
          aspectRatio: 5,
          child: foods.length > 1
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: foods.map((f) {
                    var idx = foods.indexOf(f);
                    return Expanded(
                      child: MainFoodSelectableCard(
                        food: f,
                        onTap: () => onTap(idx),
                        selected: isSelected(idx),
                      ),
                    );
                  }).toList())
              : Container(),
        ),
      ],
    );
  }
}
