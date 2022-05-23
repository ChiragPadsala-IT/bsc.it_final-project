import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MySpin extends StatelessWidget {
  final Color color;
  MySpin({
    Key? key,
    this.color = Colors.black,
  }) : super(key: key);

  // SpinKitFadingCircle spinKit = SpinKitFadingCircle(
  //   itemBuilder: (context, i) {
  //     return DecoratedBox(
  //       decoration: BoxDecoration(
  //         color: color,
  //         shape: BoxShape.circle,
  //       ),
  //     );
  //   },
  // );

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (context, i) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
