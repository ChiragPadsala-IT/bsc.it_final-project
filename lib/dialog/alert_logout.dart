import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/screen/login/login_controller.dart';
import 'package:quotes/screen/login/login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

alertLogOut({required BuildContext context}) {
  return Alert(
      context: context,
      // type: AlertType.error,
      onWillPopActive: true,
      title: "Are you sure ?",
      content: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Image.asset("assets/image/alert_dialog/logout.jpg", scale: 3),
      ),
      buttons: [
        DialogButton(
          child: const Text(
            "No",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          color: Colors.grey,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        DialogButton(
          child: const Text(
            "Yes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          color: Colors.red,
          onPressed: () async {
            final controller = Get.put(LoginController());
            if (await controller.logout()) {
              Get.offAllNamed(LoginScreen.path);
            }
          },
        ),
      ]).show();
}
