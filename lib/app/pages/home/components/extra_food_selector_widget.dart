import 'package:flutter/material.dart';

import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/pages/home/components/main_food_selector_widget.dart';

// Mostrar as comidas selecionadas de forma a ir aparecendo uma por uma
// se apenas uma for selecionada, ela ocupa todo o espaço
// caso duas sejam selecionadas, ocupar metade do espaço

//TODO: O que fazer quando nenhum acompanhamento for selecionado?

class ExtraFoodSelectorWidget extends StatefulWidget { //TODO: Passar para o main_food...
  final List<FoodModel> extraList;

  ExtraFoodSelectorWidget({
    required this.extraList,
  });

  @override
  _ExtraFoodSelectorWidgetState createState() =>
      _ExtraFoodSelectorWidgetState();
}

class _ExtraFoodSelectorWidgetState extends State<ExtraFoodSelectorWidget> {
  List<int> selectedIdxList = [];
  void onTap(int idx) {
    if (selectedIdxList.contains(idx))
      selectedIdxList.remove(idx);
    else if(selectedIdxList.length < 3)
      selectedIdxList.add(idx);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: widget.extraList.length > 1
              ? Text(
                  'Selecione até 3 acompanhamentos',
                  style: TextStyle(color: Colors.white),
                )
              : Container(),
        ),
        SizedBox(
          height: 3,
        ),
        Center(
          child: widget.extraList.length > 1
              ? Container(
                  height: 400,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:
                          1.5, //TODO: Testar o quanto o item está esticando isso
                    ),
                    itemCount: widget.extraList.length,
                    itemBuilder: (context, idx) => FoodSelectableCardWidget(
                      food: widget.extraList[idx],
                      onTap: () => onTap(idx),
                      selected: selectedIdxList.contains(idx),
                    ),
                  ))
              : Container(),
        )
      ],
    );
  }
}
