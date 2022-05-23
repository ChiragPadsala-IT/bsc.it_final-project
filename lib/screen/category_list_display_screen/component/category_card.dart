import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/model/display_quote.dart';
import 'package:quotes/screen/display_screen/display_screen.dart';

class CategoryCard extends StatelessWidget {
  String category;
  var imageURL;
  CategoryCard({
    Key? key,
    required this.category,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DisplayQuote displayQuote = DisplayQuote(
          matchQuoteFeild: category,
          searchQuoteType: "category",
          title: category,
        );
        Get.toNamed(DisplayScreen.path, arguments: [displayQuote]);
      },
      child: Container(
        height: 150,
        width: Get.width / 2.2,
        margin: const EdgeInsets.all(2),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
          image: imageURL[0] != ""
              ? DecorationImage(
                  image: Image.network(
                    imageURL[0],
                  ).image,
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                )
              : null,
          boxShadow: const [
            BoxShadow(
              offset: Offset(1, 1),
              color: Colors.black45,
              blurRadius: 5,
            ),
            BoxShadow(
              offset: Offset(-1, -1),
              color: Colors.black45,
              blurRadius: 5,
            ),
          ],
        ),
        // child: Text(
        //   category.toUpperCase(),
        //   style: const TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.w800,
        //     color: Colors.white,
        //   ),
        // ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
