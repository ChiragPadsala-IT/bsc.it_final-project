import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

MySnakBar({
  String tital = "",
  required String message,
  required Icon icon,
  SnackPosition snackPosition = SnackPosition.BOTTOM,
}) {
  return Get.snackbar(
    tital,
    message,
    icon: icon,
    snackPosition: snackPosition,
    duration: const Duration(milliseconds: 5000),
    animationDuration: const Duration(milliseconds: 700),
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
    backgroundColor: Colors.black87,
    colorText: Colors.white,
    margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
  );
}
