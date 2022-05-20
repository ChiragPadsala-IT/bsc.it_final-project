import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/category_card.dart';
import 'package:quotes/component/quote_card.dart';
import 'dart:math';

import 'package:quotes/firebase/storage/real_firebase.dart';
import 'package:quotes/screen/category_screen.dart';

class CategoriesQuotes extends StatefulWidget {
  CategoriesQuotes({Key? key}) : super(key: key);

  @override
  State<CategoriesQuotes> createState() => _CategoriesQuotesState();
}

class _CategoriesQuotesState extends State<CategoriesQuotes> {
  List myCat = [];

  late Stream _mystream;

  void initState() {
    setState(() {
      _mystream = RealTimeDatabase.getdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _mystream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            DataSnapshot dataSnapshot = snapshot.data.snapshot;
            List<DataSnapshot> l = dataSnapshot.children.toList();
            List k = l.map((DataSnapshot e) => e.key).toList();

            print("*****************************************");
            print(dataSnapshot.child(k[0]).child("image").value);
            print("*****************************************");
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quotes Category",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Get.toNamed(CategoryScreen.path);
                          print("******************************************");
                          print("******************************************");
                          print("******************************************");
                          Get.dialog(QuoteCard());
                          print("******************************************");
                          print("******************************************");
                          print("******************************************");
                        },
                        child: Text(
                          "view all >>",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  (k.length >= 4)
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CategoryCard(
                                  category: k[0],
                                  imageURL: dataSnapshot
                                      .child(k[0])
                                      .child("image")
                                      .value,
                                ),
                                CategoryCard(
                                  category: k[1],
                                  imageURL: dataSnapshot
                                      .child(k[1])
                                      .child("image")
                                      .value,
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CategoryCard(
                                  category: k[2],
                                  imageURL: dataSnapshot
                                      .child(k[2])
                                      .child("image")
                                      .value,
                                ),
                                CategoryCard(
                                  category: k[3],
                                  imageURL: dataSnapshot
                                      .child(k[3])
                                      .child("image")
                                      .value,
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            );
          }
        }
        return Text("data");
      },
    );
  }

  // Widget myCard({
  //   required String category,
  //   required var imageURL,
  // }) {
  //   print("*****************************************");
  //   print(imageURL[0]);
  //   print("*****************************************");
  //   return ClipRRect(
  //     borderRadius: BorderRadius.circular(10),
  //     child: InkWell(
  //       onTap: () {},
  //       child: Container(
  //         height: 150,
  //         width: Get.width / 2.2,
  //         alignment: Alignment.bottomCenter,
  //         decoration: BoxDecoration(
  //           color: Colors.grey,
  //           image: DecorationImage(
  //             image: Image.network(
  //               imageURL[0] ?? "",
  //             ).image,
  //             fit: BoxFit.fill,
  //           ),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black26,
  //               offset: Offset(3, 4),
  //             ),
  //           ],
  //         ),
  //         child: Container(
  //           padding: EdgeInsets.symmetric(vertical: 10),
  //           color: Colors.black54,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 category.toUpperCase(),
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w800,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
