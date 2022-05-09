import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/home/component/author_quotes.dart';
import 'package:quotes/home/component/categories_quotes.dart';
import 'package:quotes/home/component/slider.dart';
import 'package:quotes/login/login_controller.dart';
import 'package:quotes/login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static String path = "/home_screen";

  HomeScreen({Key? key}) : super(key: key);

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes"),
        leading: IconButton(
          onPressed: () async {
            if (await loginController.signOut()) {
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
    );
  }
}
