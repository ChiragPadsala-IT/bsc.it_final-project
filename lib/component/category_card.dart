import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/screen/quotes_screen.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () {
          print("******************************************");
          print("******************************************");
          print("******************************************");
          // Get.toNamed(QuotesScreen.path,arguments: []);
        },
        child: Container(
          height: 150,
          width: Get.width / 2.2,
          margin: EdgeInsets.all(2),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: Image.network(
                imageURL[0] ?? "",
              ).image,
              fit: BoxFit.fill,
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.black45,
                blurRadius: 2,
              ),
              BoxShadow(
                offset: Offset(-1, -1),
                color: Colors.black45,
                blurRadius: 2,
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
