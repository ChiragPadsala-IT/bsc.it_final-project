import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/screen/login/login_controller.dart';
import 'package:quotes/screen/login/login_screen.dart';

class ForgotDialog extends StatelessWidget {
  ForgotDialog({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  TextEditingController _fptextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _fptextEditingController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
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
                  // email = val!;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    _formkey.currentState!.save();
                    if (await Get.find<LoginController>()
                        .forgotPassword(email: _fptextEditingController.text)) {
                      Get.offAllNamed(LoginScreen.path);
                      MySnakBar(
                        tital: "Success",
                        message:
                            "link of reset password send on your email address",
                        icon: Icon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Send link on email",
                  style: TextStyle(letterSpacing: 1),
                ),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    Size(Get.width, 50),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
