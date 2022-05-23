import 'package:get/get.dart';
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
  }) async {
    if (await myAuth.signUpWithEmailAndPassword(
        email: email, password: password)) {
      return await MyCloudFireStore.addUser();
    } else {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    if (await myAuth.signInWithGoogle()) {
      return await MyCloudFireStore.addUser();
    } else {
      return false;
    }
  }
}
