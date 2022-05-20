import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quotes/component/connectivity.dart';
import 'package:quotes/component/snakbar.dart';

class myAuth {
  static GoogleSignIn? googleSignIn;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      if (await checkConnectivity()) {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        showError(
          tital: "Internet Error",
          message: "Check your internet connectivity ... ",
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
        );
        return false;
      }
      return true;
    } on FirebaseAuthException catch (err) {
      showError(
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
        print("padsala");
        print("*************************************************");
      } else {
        showError(
          tital: "Internet Error",
          message: "Check your internet connectivity ... ",
          icon: const Icon(
            Icons.warning,
            color: Colors.yellow,
          ),
        );
        return false;
      }
      return true;
    } on FirebaseAuthException catch (err) {
      showError(
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
        showError(
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
      showError(
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
      showError(
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
}
