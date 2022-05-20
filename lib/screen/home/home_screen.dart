import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/login/login_controller.dart';
import 'package:quotes/login/login_screen.dart';
import 'package:quotes/screen/home/component/author_quotes.dart';
import 'package:quotes/screen/home/component/categories_quotes.dart';
import 'package:quotes/screen/home/component/slider.dart';
import 'package:quotes/screen/quote_write/quote_write_screen.dart';
import 'package:quotes/screen/user_screen/user_screen.dart';

class HomeScreen extends StatelessWidget {
  static String path = "/home_screen";

  HomeScreen({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes"),
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed(UserScreen.path);
            },
            icon: Icon(Icons.person),
          ),
        ],
        leading: IconButton(
          onPressed: () async {
            if (await loginController.logout()) {
              Get.offAllNamed(LoginScreen.path);
            }
          },
          icon: Icon(Icons.logout),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 20),
          HomeSlider(),
          const Divider(height: 40, thickness: 2),
          CategoriesQuotes(),
          const SizedBox(height: 20),
          AuthorQuotes(),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(QuoteWriteScreen.path);
          },
          child: Icon(FontAwesomeIcons.pencil),
          heroTag: "write_quotes",
        ),
      ),
    );
  }
}
