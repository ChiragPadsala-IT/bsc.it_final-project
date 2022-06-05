import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _bestQuotes;

  @override
  void initState() {
    _bestQuotes = MyCloudFireStore.getBestQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bestQuotes,
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        // print("******************start**************************");
        // Map<String, dynamic>? m = d as Map<String, dynamic>?;
        // print(d[0]["image"]);
        // print("******************end**************************");
        // return Text("");
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            var d = snapshot.data!.docs;
            return Container(
              child: CarouselSlider(
                items: d
                    .map((e) => Container(
                          width: Get.width / 0.25,
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            e["quote"],
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.black,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(2, 2),
                                color: Colors.black45,
                                blurRadius: 2,
                              ),
                              BoxShadow(
                                offset: Offset(-2, -2),
                                color: Colors.black45,
                                blurRadius: 2,
                              ),
                            ],
                            image: DecorationImage(
                              image: NetworkImage(e["image"]),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.darken,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  aspectRatio: 4 / 2.2,
                  enlargeCenterPage: true,
                  pageSnapping: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.easeInOut,
                  // onPageChanged: (i, CarouselPageChangedReason val) {
                  //   print(i);
                  // },
                ),
              ),
            );
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        } else {
          return MySpin();
        }
      },
    );

    // return Container(
    //   child: CarouselSlider(
    //     items: [1, 2, 3]
    //         .map((e) => Container(
    //               color: Colors.amber,
    //             ))
    //         .toList(),
    //     options: CarouselOptions(
    //       aspectRatio: 4 / 2,
    //       enlargeCenterPage: true,
    //       pageSnapping: true,
    //       // autoPlay: true,
    //       autoPlayCurve: Curves.easeInOut,
    //       // onPageChanged: (i, CarouselPageChangedReason val) {
    //       //   print(i);
    //       // },
    //     ),
    //   ),
    // );
  }
}
