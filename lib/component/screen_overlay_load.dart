import 'package:flutter/material.dart';
import 'package:quotes/component/myspin.dart';

myScreenOverlay({required BuildContext context, required String message}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MySpin(
            color: Colors.white,
          ),
          SizedBox(height: 5),
          Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
    },
  );
}
