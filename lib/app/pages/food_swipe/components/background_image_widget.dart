import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final String imgUrl;

  const BackgroundImageWidget({Key? key, required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          color: Colors.black.withOpacity(0.25),
        ),
      ),
    );
  }
}
