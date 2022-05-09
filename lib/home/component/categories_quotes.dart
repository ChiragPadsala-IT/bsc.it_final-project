import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class CategoriesQuotes extends StatelessWidget {
  CategoriesQuotes({Key? key}) : super(key: key);

  List myCat = [
    "Birthday",
    "Friend",
    "Inspiration",
    "Special",
    "Days",
    "Night",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quotes By Categories",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              myCard(category: "Hello"),
              myCard(category: "Hello"),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              myCard(category: "Hello"),
              myCard(category: "Hello"),
            ],
          ),
        ],
      ),
    );
  }

  Widget myCard({required String category}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 150,
          width: Get.width / 2.2,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            color: Colors.amber,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(3, 4),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
