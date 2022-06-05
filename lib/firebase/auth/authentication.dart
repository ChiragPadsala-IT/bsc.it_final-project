import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quotes/component/connectivity.dart';
import 'package:quotes/component/screen_overlay_load.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/screen/login/login_screen.dart';

class myAuth {
  static GoogleSignIn? googleSignIn;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static late Timer timer;

  static checkEmailVerifide({required BuildContext context}) async {
    firebaseAuth.currentUser!.reload();
    if (firebaseAuth.currentUser!.emailVerified) {
      myScreenOverlay(context: context, message: "");
      await MyCloudFireStore.addUser();
      timer.cancel();
      Get.offAllNamed(LoginScreen.path);
      MySnakBar(
        tital: "Success",
        message: "Email is verified successfully.",
        icon: const Icon(
          FontAwesomeIcons.check,
          color: Colors.green,
        ),
      );
    }
  }

  static Future signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      if (await checkConnectivity()) {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await firebaseAuth.currentUser!.sendEmailVerification();
        timer = Timer.periodic(
          const Duration(seconds: 5),
          (timer) async {
            // print('******************' +
            //     timer.toString() +
            //     '*******************');
            checkEmailVerifide(context: context);
          },
        );
        // await verifyemail(context: context);
        return true;
      } else {
        Get.back();
        MySnakBar(
          tital: "Internet Error",
          message: "Check your internet connectivity ... ",
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
        );
        return false;
      }
    } on FirebaseAuthException catch (err) {
      Get.back();
      MySnakBar(
        tital: err.code.toString(),
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (await checkConnectivity()) {
        print("*************************************************");
        print("chirag");
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          return true;
        } else {
          MySnakBar(
            tital: "Verification error",
            message: "Email is not verified ... ",
            icon: const Icon(
              FontAwesomeIcons.question,
              color: Colors.red,
            ),
          );
          return false;
        }
      } else {
        MySnakBar(
          tital: "Internet Error",
          message: "Check your internet connectivity ... ",
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
        );
        return false;
      }
    } on FirebaseAuthException catch (err) {
      MySnakBar(
        tital: err.code.toString(),
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future<bool> signInWithGoogle() async {
    print("1");
    try {
      if (await checkConnectivity()) {
        // Trigger the authentication flow
        googleSignIn = GoogleSignIn();

        final GoogleSignInAccount? googleUser = await googleSignIn?.signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
          accessToken: googleAuth?.accessToken,
        );
        // UserCredential userCredential =
        //     await FirebaseAuth.instance.signInWithCredential(credential);
        // print(userCredential.user?.email);

        // Once signed in, return the UserCredential
        await firebaseAuth.signInWithCredential(credential);
        print("*****************padsala*********************");
        return true;
      } else {
        MySnakBar(
          tital: "Internet Error",
          message: "Check your internet connectivity ... ",
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
        );
        return false;
      }
    } on FirebaseAuthException catch (err) {
      MySnakBar(
        tital: err.code.toString(),
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future signOut() async {
    try {
      if (googleSignIn != null) {
        await Future.wait([
          firebaseAuth.signOut(),
          googleSignIn!.signOut(),
        ]);
      } else {
        await Future.wait([
          firebaseAuth.signOut(),
        ]);
      }
      return true;
    } on FirebaseAuthException catch (err) {
      MySnakBar(
        tital: err.code.toString(),
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future<bool> forgotPassword({required String email}) async {
    try {
      firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseException catch (err) {
      MySnakBar(
        tital: err.code,
        message: err.message.toString(),
        icon: Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }
}
