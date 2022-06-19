import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quotes/screen/login/login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

verifyemail({required BuildContext context}) {
  return Alert(
    context: context,
    title: "Send Email Verification Link",
    type: AlertType.success,
    closeFunction: null,
    closeIcon: null,
    onWillPopActive: false,
    content: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const Text(
          "verification link send successfully on your account.If already verifly wait few second. "),
    ),
    buttons: [
      DialogButton(
          child: Text("Ok"),
          onPressed: () {
            Get.offAllNamed(LoginScreen.path);
          })
    ],
  ).show();
}
