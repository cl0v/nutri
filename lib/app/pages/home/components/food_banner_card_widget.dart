import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodBannerCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String type;
  final bool isTapabble;
  final Color? color;
  final VoidCallback onBannerTapped;

  const FoodBannerCardWidget({
    required this.image,
    required this.type,
    required this.title,
    required this.isTapabble,
    required this.onBannerTapped,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isTapabble ? onBannerTapped : null,
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color ?? null,
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
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '$type\n$title',
                            textAlign: TextAlign.center,
                            style: Get.theme!.textTheme.headline6,
                          ),
                        ),
                        isTapabble ? 
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                        ) : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
