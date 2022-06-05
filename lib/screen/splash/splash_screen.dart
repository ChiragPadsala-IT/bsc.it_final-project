import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quotes/screen/home/home_screen.dart';
import 'package:quotes/screen/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static String path = "/splash_screen";

  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final spinKit = SpinKitFadingCircle(
    itemBuilder: (context, i) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      );
    },
  );

  @override
  void initState() {
    Timer(const Duration(milliseconds: 2000), () {
      FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? Get.offAllNamed(HomeScreen.path)
          : Get.offAllNamed(LoginScreen.path);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 175,
              width: 175,
              alignment: Alignment.center,
              // color: Colors.black,
              child: Image.asset(
                "assets/image/splash_screen/icon_image.png",
                // fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            child: spinKit,
            bottom: 150,
            right: Get.width / 2.25,
          ),
        ],
      ),
    );
  }
}
