import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';

import 'package:nutri/app/modules/food_swipe/components/background_image.dart';
import 'package:nutri/app/modules/food_swipe/components/food_card.dart';
import 'package:nutri/app/modules/food_swipe/controllers/food_swipe_controller.dart';

class BlurBgImgCarroussel extends StatefulWidget {
  @override
  _BlurBgImgCarrousselState createState() => _BlurBgImgCarrousselState();
}

class _BlurBgImgCarrousselState extends State<BlurBgImgCarroussel> {
  PageController _pageController;
  double _currentPageValue = 0.0;

  // final controller = Get.find<FoodSwipeController>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8)
      ..addListener(
        () {
          setState(() {
            _currentPageValue = _pageController.page;
          });
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          imgUrl: items[_currentPageValue.round()]['image'],
        ),
        Center(
          child: Container(
            height: 450,
            child: PageView.builder(
              controller: _pageController,
              itemCount: items.length,
              itemBuilder: (context, index) {
                // 0.0 ~ 1.0
                var scale = (1 - (_currentPageValue - index).abs());

                return FoodCard(scale: scale, index: index, items: items,);
              },
            ),
          ),
        ),
      ],
    );
  }
}


const items = [
  {
    'title': 'Fi',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1547721064-da6cfb341d50?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1552053831-71594a27632d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=624&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1552728089-57bdde30beb3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=734&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80',
  },
  {
    'title': 'Test',
    'text':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image':
        'https://images.unsplash.com/photo-1589656966895-2f33e7653819?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  },
];
