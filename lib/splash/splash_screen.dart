import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:quotes/home/home_screen.dart';
import 'package:quotes/login/login_screen.dart';

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

  // @override
  // void initState() {
  //   Timer(Duration(seconds: 5), () {
  //     FirebaseAuth.instance.currentUser != null
  //         ? Get.offAllNamed(HomeScreen.path)
  //         : Get.offAllNamed(LoginScreen.path);
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            child: SizedBox.expand(
              child: Image.asset(
                "assets/image/splash_screen/splash_screen_image.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Column(
              //   children: [

              //     Text(
              //       "Quotes",
              //       style: TextStyle(
              //         fontFamily: 'Fluo',
              //         fontSize: 34,
              //         fontWeight: FontWeight.w700,
              //         letterSpacing: 4,
              //       ),
              //     ),
              //     SizedBox(height: Get.height / 5),
              //     spinKit,
              //   ],
              // ),
            ],
          )
        ],
      ),
    );
  }
}
