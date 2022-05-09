import 'package:get/get.dart';
import 'package:quotes/firebase/auth/authentication.dart';

class SignUpController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (await myAuth()
        .signUpWithEmailAndPassword(email: email, password: password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    if (await myAuth().signInWithGoogle()) {
      return true;
    } else {
      return false;
    }
  }
}
