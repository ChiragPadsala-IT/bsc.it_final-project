import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        items: [1, 2, 3]
            .map((e) => Container(
                  color: Colors.amber,
                ))
            .toList(),
        options: CarouselOptions(
          aspectRatio: 4 / 2,
          enlargeCenterPage: true,
          pageSnapping: true,
          // autoPlay: true,
          autoPlayCurve: Curves.easeInOut,
          // onPageChanged: (i, CarouselPageChangedReason val) {
          //   print(i);
          // },
        ),
      ),
    );
  }
}
