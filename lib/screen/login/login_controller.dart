import 'package:get/get.dart';
import 'package:quotes/firebase/auth/authentication.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';

class LoginController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print("*****************hello*********************");
    if (await myAuth.loginWithEmailAndPassword(
        email: email, password: password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    if (await myAuth.signInWithGoogle()) {
      return await MyCloudFireStore.addUser();
    } else {
      return false;
    }
  }

  Future logout() async {
    return await myAuth.signOut();
    // if (await myAuth.signOut()) {
    //   return true;
    // } else {
    //   return false;
    // }
  }

  Future forgotPassword({required String email}) async {
    return await myAuth.forgotPassword(email: email);
  }
}
