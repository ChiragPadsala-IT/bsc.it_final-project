import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/component/screen_overlay_load.dart';
import 'package:quotes/screen/home/home_screen.dart';
import 'package:quotes/screen/login/Forgot_dialog/forgot_dialog.dart';
import 'package:quotes/screen/login/login_controller.dart';
import 'package:quotes/screen/onboarding_screen/onboarding_screen.dart';
import 'package:quotes/screen/signup/signup_screen.dart';

import '../../component/snakbar.dart';

class LoginScreen extends StatelessWidget {
  static String path = "/login_screen";

  LoginScreen({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _utextEditingController = TextEditingController();
  final TextEditingController _ptextEditingController = TextEditingController();

  final logincontroller = Get.put(LoginController());

  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 175,
                  width: 175,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 50),
                  // color: Colors.black,
                  child: Image.asset(
                    "assets/image/splash_screen/icon_image.png",
                    // fit: BoxFit.fill,
                  ),
                ),
                // Container(
                //   height: 100,
                //   width: 100,
                //   child: Image.network(
                //     "https://cpng.pikpng.com/pngl/s/184-1840024_athletics-forms-transparent-background-forms-icon-clipart.png",
                //   ),
                // ),
                Row(
                  children: const [
                    Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: CupertinoColors.black,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _utextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Email",
                    label: Text("Enter Your Email"),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (GetUtils.isEmail(val!)) {
                      return null;
                    }
                    return "Invalid email address";
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ptextEditingController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Password",
                    label: Text("Enter Your Password"),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val != null && val.length > 7) {
                      return null;
                    }

                    return "password must be more than 7 character";
                  },
                  onSaved: (val) {
                    password = val!;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: "Forgot password? ",
                        style: TextStyle(color: Colors.blue[700]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.dialog(ForgotDialog());
                          },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      myScreenOverlay(context: context, message: "");
                      if (await logincontroller.loginWithEmailAndPassword(
                        email: email,
                        password: password,
                      )) {
                        Get.back();
                        await Get.dialog(OnBoardingDialog());
                        Get.offAllNamed(HomeScreen.path);
                      } else {
                        Get.back();
                        MySnakBar(
                          tital: "Verification error",
                          message: "Email is not verified ... ",
                          icon: const Icon(
                            FontAwesomeIcons.question,
                            color: Colors.red,
                          ),
                        );
                      }
                      // Get.back();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(letterSpacing: 1),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(Get.width, 50),
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                const Center(
                  child: Text(
                    "OR",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 7),
                ElevatedButton(
                  onPressed: () async {
                    if (await logincontroller.loginWithGoogle()) {
                      await Get.dialog(OnBoardingDialog());
                      Get.offAndToNamed(HomeScreen.path);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(FontAwesomeIcons.google),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Login with Google",
                            style: TextStyle(letterSpacing: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      Size(Get.width / 1.5, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red[800]),
                  ),
                ),
                const SizedBox(height: 40),
                Text.rich(
                  TextSpan(
                    text: "Do you don't have account?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "\tSign Up",
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(SignUpScreen.path);
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height / 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
