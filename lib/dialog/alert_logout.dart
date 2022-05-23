import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/screen/login/login_controller.dart';
import 'package:quotes/screen/login/login_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

alertLogOut({required BuildContext context}) {
  return Alert(
      context: context,
      // type: AlertType.error,

      title: "Are you sure ?",
      content: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Image.asset("assets/image/alert_dialog/logout.jpg", scale: 3),
      ),
      buttons: [
        DialogButton(
          child: Text(
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
          child: Text(
            "Yes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          color: Colors.red,
          onPressed: () async {
            if (await Get.find<LoginController>().logout()) {
              Get.offAllNamed(LoginScreen.path);
            }
          },
        ),
      ]).show();
}
