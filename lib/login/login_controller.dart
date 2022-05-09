import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quotes/component/connectivity.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/firebase/auth/authentication.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/model/user.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await myAuth()
        .loginWithEmailAndPassword(email: email, password: password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    if (await myAuth().signInWithGoogle()) {
      User user = FirebaseAuth.instance.currentUser!;
      MyUser myUser = MyUser(
        id: user.uid,
        email: user.email.toString(),
      );
      MyCloudFireStore().addUser(myuser: myUser);
      return true;
    } else {
      return false;
    }
  }

  Future signOut() async {
    if (await myAuth().signOut()) {
      return true;
    } else {
      return false;
    }
  }
}
