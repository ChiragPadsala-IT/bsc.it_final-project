import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MySpin extends StatelessWidget {
  MySpin({Key? key}) : super(key: key);

  final spinKit = SpinKitFadingCircle(
    itemBuilder: (context, i) {
      return const DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return spinKit;
  }
}
