import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutri/app/data/model/extras_model.dart';

class ExtrasSelectableCard extends StatelessWidget {
  final ExtraModel extra;
  final bool selected;
  final Function onTap;

  const ExtrasSelectableCard({Key key, this.extra, this.onTap, this.selected = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap
        //TODO: Trocar a cor do item para verde com opacidade
      ,
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(
              //TODO: Trocar para assets
              extra.food.img,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: selected
                  ? Colors.green.withOpacity(.4)
                  : Colors.black.withOpacity(.3) //Trocar a cor
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center(
              //   child:
              Text(
                extra.food.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                extra.amount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                extra.unidade,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
    );

    return Container(
      height: 90,
      width: 90,
      margin: EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/foods/agua.jpg'), //Trocar por ASSETIMAGE
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: 0,
                  top: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                //TODO: Adicionar botao de informacoes Icon.info
                //TODO: Modificar os botoes concluido e 'passei'
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Beba água',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
