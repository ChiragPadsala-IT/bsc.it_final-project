import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/dialog/alert_logout.dart';
import 'package:quotes/model/display_quote.dart';
import 'package:quotes/screen/display_screen/display_screen.dart';
import 'package:quotes/screen/profile_screen/profile_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 2,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: Get.height / 4.5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage("assets/image/drawer/title_image.png"),
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.1),
                        BlendMode.lighten,
                      ),
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Favorite Quotes"),
                  leading: Icon(Icons.favorite, color: Colors.red),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    DisplayQuote displayQuote = DisplayQuote(
                      matchQuoteFeild: "",
                      searchQuoteType: "favorite",
                      title: "favorite",
                    );
                    Get.toNamed(DisplayScreen.path, arguments: [displayQuote]);
                  },
                ),
                ListTile(
                  title: Text("Quote of the day"),
                  leading:
                      Icon(FontAwesomeIcons.penToSquare, color: Colors.purple),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    DisplayQuote displayQuote = DisplayQuote(
                      matchQuoteFeild: "",
                      searchQuoteType: "quote_of_the_day",
                      title: "quote of the day",
                    );
                    Get.toNamed(DisplayScreen.path, arguments: [displayQuote]);
                  },
                ),
                ListTile(
                  title: Text("Profile"),
                  leading:
                      Icon(FontAwesomeIcons.person, color: Colors.orangeAccent),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Get.toNamed(ProfileScreen.path);
                  },
                ),
                ListTile(
                  title: Text("Public Quotes"),
                  leading: Icon(Icons.people, color: Colors.green[400]),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    DisplayQuote displayQuote = DisplayQuote(
                      matchQuoteFeild: "",
                      searchQuoteType: "public",
                      title: "Public Quotes",
                    );
                    Get.toNamed(DisplayScreen.path, arguments: [displayQuote]);
                  },
                ),
                ListTile(
                  title: Text("Private Quotes"),
                  leading: Icon(Icons.lock, color: Colors.redAccent[100]),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    DisplayQuote displayQuote = DisplayQuote(
                      matchQuoteFeild: "",
                      searchQuoteType: "private",
                      title: "Private Quotes",
                    );
                    Get.toNamed(DisplayScreen.path, arguments: [displayQuote]);
                  },
                ),
              ],
            ),
            Column(
              children: [
                Divider(),
                ListTile(
                  title: Text("Log Out"),
                  leading:
                      Icon(Icons.logout, color: CupertinoColors.destructiveRed),
                  dense: true,
                  onTap: () async {
                    alertLogOut(context: context);
                  },
                ),
                Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
