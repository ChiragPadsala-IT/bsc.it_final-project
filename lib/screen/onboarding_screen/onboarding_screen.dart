import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingDialog extends StatefulWidget {
  OnBoardingDialog({Key? key}) : super(key: key);

  @override
  State<OnBoardingDialog> createState() => _OnBoardingDialogState();
}

class _OnBoardingDialogState extends State<OnBoardingDialog> {
  List<String> imageList = [
    "assets/image/on_boarding/1.png",
    "assets/image/on_boarding/2.png",
    "assets/image/on_boarding/3.png",
  ];

  late String selectedBoard = imageList[0];
  late bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CarouselSlider.builder(
              itemCount: imageList.length,
              itemBuilder: (context, i, _) {
                return Image.asset(
                  imageList[i],
                  fit: BoxFit.fill,
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                height: Get.height,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                onPageChanged: (val, res) {
                  setState(() {
                    selectedBoard = imageList[val];
                    print(imageList.last);
                    print(isDone);
                    if (imageList[val] == imageList.last && isDone == false) {
                      setState(() {
                        isDone = true;
                      });
                      print("hello Chirag");
                    }
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.map(
                  (e) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor:
                            selectedBoard == e ? Colors.indigo : Colors.grey,
                        radius: 7,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          isDone
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("Done"),
                    ),
                  ),
                )
              : Container(),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
