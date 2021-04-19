import 'package:flutter/material.dart';
import 'package:nutri/app/models/food_model.dart';

//FIXME: Não está intuitivo o suficiente que é para tocar em alguma das comidas

class MainFoodSelectorWidget extends StatefulWidget {
  final List<FoodModel> foodList;
  final int selectedIdx;
  final bool isTappable;
  final Function onTap;

  MainFoodSelectorWidget({
    required this.foodList,
    required this.isTappable,
    required this.selectedIdx,
    required this.onTap,
  });

  @override
  _MainFoodSelectorWidgetState createState() => _MainFoodSelectorWidgetState();
}

class _MainFoodSelectorWidgetState extends State<MainFoodSelectorWidget> {
  var _selectedIndex = 0;

  // final controller = Get.find<HomeController>();
  onTap(int idx) {
    widget.onTap(idx);
    setState(() {
      _selectedIndex = idx;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIdx;
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.foodList.map((f) {
              var idx = widget.foodList.indexOf(f);
              return Expanded(
                child: FoodSelectableCardWidget(
                  food: f,
                  onTap: () => widget.isTappable ? onTap(idx) : null,
                  selected: idx == _selectedIndex,
                ),
              );
            }).toList(),
          ),
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
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExtraFoodSelectorWidget extends StatefulWidget {
  final List<FoodModel> extraList;
  final bool isTappable;

  ExtraFoodSelectorWidget({
    required this.extraList,
    required this.isTappable,
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
    else if (selectedIdxList.length < 3) selectedIdxList.add(idx);
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
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio:
                  1.5, //TODO: Testar o quanto o item está esticando isso
            ),
            itemCount: widget.extraList.length,
            itemBuilder: (context, idx) => FoodSelectableCardWidget(
              food: widget.extraList[idx],
              onTap: () => widget.isTappable ? onTap(idx) : null,
              selected: selectedIdxList.contains(idx),
            ),
          ),
        )
      ],
    );
  }
}
