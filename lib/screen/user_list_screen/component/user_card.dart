import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/model/display_quote.dart';
import 'package:quotes/screen/display_screen/display_screen.dart';

class UserCard extends StatelessWidget {
  final String user;
  final String uID;
  final List<Color> gradientColor;
  const UserCard({
    Key? key,
    required this.uID,
    required this.user,
    required this.gradientColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(uID);
        DisplayQuote displayQuote = DisplayQuote(
          matchQuoteFeild: uID,
          searchQuoteType: "user",
          title: user.split("@")[0],
        );
        Get.toNamed(DisplayScreen.path, arguments: [displayQuote]);
      },
      child: Container(
        height: 150,
        width: Get.width / 2.25,
        alignment: Alignment.center,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Colors.black26,
              offset: Offset(-1, -1),
              blurRadius: 5,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColor,
          ),
        ),
        child: Text(
          user.split("@")[0],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
