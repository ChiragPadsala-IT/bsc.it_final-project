import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/component/drawer.dart';
import 'package:quotes/dialog/alert_logout.dart';
import 'package:quotes/model/display_quote.dart';
import 'package:quotes/screen/display_screen/display_screen.dart';
import 'package:quotes/screen/home/component/usefull_quote.dart';
import 'package:quotes/screen/onboarding_screen/onboarding_screen.dart';
import 'package:quotes/screen/usefull_quotes_screen/usefull_quotes_screen.dart';
import 'package:quotes/screen/home/component/user_quotes.dart';
import 'package:quotes/screen/home/component/categories_quotes.dart';
import 'package:quotes/screen/home/component/slider.dart';
import 'package:quotes/screen/login/login_controller.dart';
import 'package:quotes/screen/login/login_screen.dart';
import 'package:quotes/screen/profile_screen/profile_screen.dart';
import 'package:quotes/screen/quote_write_screen/quote_write_screen.dart';

class HomeScreen extends StatelessWidget {
  static String path = "/home_screen";

  HomeScreen({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("Quotes"),

        // leading: IconButton(
        //   onPressed: () async {
        //     if (await loginController.logout()) {
        //       Get.offAllNamed(LoginScreen.path);
        //     }
        //   },
        //   icon: Icon(Icons.logout),
        // ),
      ),
      body: ListView(
        // physics: const BouncingScrollPhysics(),

        children: [
          const SizedBox(height: 20),
          HomeSlider(),
          const Divider(height: 40, thickness: 2),
          CategoriesQuotes(),
          const SizedBox(height: 20),
          UserQuotes(),
          const SizedBox(height: 20),
          UseFullQuotes(),
          // UserFullQuotes(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(QuoteWriteScreen.path);
            // Get.dialog(OnBoardingDialog());
          },
          child: Icon(FontAwesomeIcons.penToSquare),
          heroTag: "write_quotes",
        ),
      ),
    );
  }
}
