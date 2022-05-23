import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/screen/usefull_quotes_screen/usefull_quotes_screen.dart';

class UseFullQuotes extends StatelessWidget {
  const UseFullQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: InkWell(
        onTap: () {
          Get.toNamed(UseFullQuotesScreen.path);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: Colors.grey[700],
              child: Text(
                "UseFull Quotes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Container(
              width: Get.width,
              height: 150,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Some User Full Quotes >>>",
                style: TextStyle(
                  color: CupertinoColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(2, 2),
                    color: Colors.black45,
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    offset: Offset(-2, -2),
                    color: Colors.black45,
                    blurRadius: 2,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(
                      "assets/image/usefull_quote/usefull_quotes.jpg"),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
