import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: Get.height / 1.5,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                RepaintBoundary(
                  // key: listOfGlobalKey[i],
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: Image.network(
                          "https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2018/10/bluebells,_oxfordshire.jpg?fit=1500%2C1000&ssl=1",
                          // img[imgNumber[i]],
                          fit: BoxFit.fill,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                      const SizedBox.expand(
                        child: Material(
                          color: Colors.black26,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 12,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "https://i0.wp.com/digital-photography-school.com/wp-content/uploads/2018/10/bluebells,_oxfordshire.jpg?fit=1500%2C1000&ssl=1",
                                // dataList[i].quotes,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    letterSpacing: 2),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "~",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          letterSpacing: 2),
                                    ),
                                    Text(
                                      "chirag",
                                      // dataList[i].author,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          letterSpacing: 2),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            // setState(() {
                            //   if (imgNumber[i] == 4) {
                            //     imgNumber[i] = 0;
                            //   } else {
                            //     imgNumber[i]++;
                            //   }
                            // });
                          },
                          icon: Icon(
                            Icons.camera,
                            color: Colors.lightGreenAccent,
                          ),
                          iconSize: 35,
                        ),
                        IconButton(
                          onPressed: () async {
                            // await FlutterClipboard.copy(dataList[i].quotes);
                            // ScaffoldMessenger.of(context)
                            //     .removeCurrentSnackBar();
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content:
                            //         Text("${dataList[i].quotes} is copied"),
                            //   ),
                            // );
                          },
                          icon: Icon(
                            Icons.copy,
                            color: Colors.blue,
                          ),
                          iconSize: 35,
                        ),
                        PopupMenuButton(
                          elevation: 10,
                          icon: Icon(
                            Icons.share,
                            color: Colors.red,
                          ),
                          iconSize: 35,
                          onSelected: (val) async {
                            if (val == 0) {
                              // await Share.share(dataList[i].quotes);
                            } else {
                              // await shareAsImage(listOfGlobalKey[i]);
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                child: Text("Share as Text"),
                                value: 0,
                              ),
                              PopupMenuItem(
                                child: Text("Share as Image"),
                                value: 1,
                              ),
                            ];
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            // await saveImage(listOfGlobalKey[i]);
                          },
                          icon: Icon(
                            Icons.download_rounded,
                            color: Colors.green,
                          ),
                          iconSize: 35,
                        ),
                        // IconButton(
                        //   onPressed: () async {
                        //     // print(isFavorite[i]);
                        //     // if (isFavorite[i] == false) {
                        //     //   setState(() {
                        //     //     isFavorite[i] = true;
                        //     //   });
                        //     //   int res = await dbh.insertFVDB(dataList[i]);

                        //     //   if (res == dataList[i].id) {
                        //     //     ScaffoldMessenger.of(context)
                        //     //         .removeCurrentSnackBar();
                        //     //     ScaffoldMessenger.of(context).showSnackBar(
                        //     //         SnackBar(
                        //     //             content: Text(
                        //     //                 "Added in favorite list ...")));
                        //     //   }
                        //     // } else {
                        //     //   setState(() {
                        //     //     isFavorite[i] = false;
                        //     //   });
                        //     //   int res =
                        //     //       await dbh.deleteFVDBDATA(dataList[i].id);
                        //     //   print(res);
                        //     //   if (res == 1) {
                        //     //     ScaffoldMessenger.of(context)
                        //     //         .removeCurrentSnackBar();
                        //     //     ScaffoldMessenger.of(context).showSnackBar(
                        //     //         SnackBar(
                        //     //             content: Text(
                        //     //                 "Remove into favorite list ...")));
                        //     //   }
                        //     // }
                        //   // },
                        //   // icon: (isFavorite[i])
                        //   //     ? Icon(
                        //   //         Icons.star,
                        //   //         color: Colors.amberAccent,
                        //   //       )
                        //   //     : Icon(
                        //   //         Icons.star_border,
                        //   //         color: Colors.amberAccent,
                        //   //       ),
                        //   },
                        //   iconSize: 35,
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
