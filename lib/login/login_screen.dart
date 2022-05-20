import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quotes/login/login_controller.dart';
import 'package:quotes/screen/home/home_screen.dart';
import 'package:quotes/signup/signup_screen.dart';

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
      resizeToAvoidBottomInset: true,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 10),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: const [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                    return "Invalid emial address";
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
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      if (await logincontroller.loginWithEmailAndPassword(
                        email: email,
                        password: password,
                      )) {
                        Get.offAllNamed(HomeScreen.path);
                      }
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
                const Center(child: Text("OR")),
                const SizedBox(height: 7),
                ElevatedButton(
                  onPressed: () async {
                    if (await logincontroller.loginWithGoogle()) {
                      Get.toNamed(HomeScreen.path);
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
                    children: [
                      TextSpan(
                        text: "\tSign Up",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(SignUpScreen.path);
                          },
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
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
