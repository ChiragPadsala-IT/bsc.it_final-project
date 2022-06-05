import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quotes/component/screen_overlay_load.dart';
import 'package:quotes/dialog/verify_your_email.dart';
import 'package:quotes/firebase/auth/authentication.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';

class SignUpController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    myScreenOverlay(context: context, message: "");
    return await myAuth.signUpWithEmailAndPassword(
      email: email,
      password: password,
      context: context,
    );
    // if (await myAuth.signUpWithEmailAndPassword(
    //   email: email,
    //   password: password,
    //   context: context,
    // )) {
    //   if (await FirebaseAuth.instance.currentUser!.emailVerified) {
    //     return await MyCloudFireStore.addUser();
    //   }
    // } else {
    //   return false;
    // }
  }

  Future<bool> signInWithGoogle() async {
    if (await myAuth.signInWithGoogle()) {
      return await MyCloudFireStore.addUser();
    } else {
      return false;
    }
  }
}
