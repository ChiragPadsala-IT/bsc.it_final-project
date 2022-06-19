import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/component/screen_overlay_load.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/model/upload_quote.dart';
import 'package:quotes/screen/profile_screen/profile_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class QuoteCard extends StatefulWidget {
  final String quote;
  final String image;
  final String docID;
  final String searchType;
  final int quoteLength;
  final VoidCallback myCallBack;

  QuoteCard({
    Key? key,
    required this.image,
    required this.quote,
    required this.docID,
    required this.searchType,
    required this.quoteLength,
    required this.myCallBack,
  }) : super(key: key);

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  int changeImage = 0;

  List imageList = [
    "https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q=",
    "https://iso.500px.com/wp-content/uploads/2016/03/stock-photo-142984111-1500x1000.jpg",
    "https://media.istockphoto.com/photos/in-the-hands-of-trees-growing-seedlings-bokeh-green-background-female-picture-id1181366400?k=20&m=1181366400&s=612x612&w=0&h=p-iaAHKhxsF6Wqrs7QjbwjOYAFBrJYhxlLLXEX1wsGs=",
    "https://images.assettype.com/fortuneindia%2F2020-06%2Fef53f9be-f257-4aa3-9af5-6ca1a9f33a86%2Fclose_up_photography_of_leaves_with_droplets_807598.jpg?rect=0,607,4128,2322&w=1250&q=60",
  ];

  GlobalKey _imgKey = GlobalKey();
  // String title = ModalRoute.of(context).settings.arguments;
  // List listOfGlobalKey = List.generate(dataList.length, (index) => GlobalKey());

  shareAsImage(var key) async {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();

    ui.Image image = await boundary.toImage(pixelRatio: 3);
    // image.toByteData(format: ui.ImageByteFormat.png);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngImg = byteData!.buffer.asUint8List();

    var directory = await getTemporaryDirectory();
    File imgFile = File("${directory.path}/my_img.png");
    await imgFile.writeAsBytes(pngImg);
    Navigator.pop(context);
    await Share.shareFiles([imgFile.path]);
  }

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
            height: Get.width,
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
                  key: _imgKey,
                  child: Stack(
                    children: [
                      // SizedBox.expand
                      Container(
                        height: Get.width,
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          gradient: LinearGradient(
                            colors: [Colors.indigo, Colors.orange],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: changeImage == 0
                            ? widget.image == ""
                                ? null
                                : Image.network(
                                    widget.image,
                                    // img[imgNumber[i]],
                                    fit: BoxFit.fill,
                                    colorBlendMode: BlendMode.darken,
                                    color: Colors.black38,
                                  )
                            : Image.network(
                                imageList[changeImage - 1],
                                fit: BoxFit.fill,
                                colorBlendMode: BlendMode.darken,
                                color: Colors.black38,
                              ),
                      ),
                      const SizedBox.expand(
                        child: Material(
                          color: Colors.black26,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 12,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.quote,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              letterSpacing: 2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.white,
                    width: Get.width,
                    height: 53,
                    child: widget.searchType == "all"
                        ? ElevatedButton.icon(
                            onPressed: () async {
                              UploadQuote uploadQuote = UploadQuote(
                                image: widget.image,
                                quote: widget.quote,
                                quote_category: "",
                                time: DateTime.now().millisecondsSinceEpoch,
                                uid: "",
                                searchType: "quote_of_the_day",
                              );
                              myScreenOverlay(
                                context: context,
                                message: "wait a minute",
                              );
                              if (await MyCloudFireStore.uploadQuote(
                                uploadQuote: uploadQuote,
                              )) {
                                Get.back();
                                MySnakBar(
                                  tital: "Success",
                                  message:
                                      "quote of the day change successfully...",
                                  icon: Icon(FontAwesomeIcons.check,
                                      color: Colors.green),
                                );
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                            ),
                            icon: Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.lightGreenAccent,
                              size: 35,
                            ),
                            label: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (changeImage == 4) {
                                      changeImage = 0;
                                    } else {
                                      changeImage++;
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.camera,
                                  color: Colors.lightGreenAccent,
                                ),
                                iconSize: 35,
                              ),
                              IconButton(
                                onPressed: () async {
                                  print(
                                      "**************************************");
                                  FlutterClipboard.copy(widget.quote)
                                      .then((value) {
                                    MySnakBar(
                                      tital: "Success",
                                      message: "Text copied successfully...",
                                      icon: Icon(
                                        FontAwesomeIcons.check,
                                        color: Colors.green[700],
                                      ),
                                    );
                                  });
                                  print(
                                      "**************************************");
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
                                  color: Colors.teal,
                                ),
                                iconSize: 35,
                                onSelected: (val) async {
                                  if (val == 0) {
                                    await Share.share(widget.quote);
                                  } else {
                                    myScreenOverlay(
                                        context: context,
                                        message:
                                            "wait a moment quote is preparing...");
                                    await shareAsImage(_imgKey);
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
                              widget.docID != ""
                                  ? Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        iconSize: 35,
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async {
                                          String t = widget.quote;
                                          myScreenOverlay(
                                            context: context,
                                            message: "wait a minute",
                                          );
                                          if (widget.searchType ==
                                                  "slider_quotes" &&
                                              widget.quoteLength < 4) {
                                            Get.back();
                                            MySnakBar(
                                              tital: "Warning",
                                              message:
                                                  "Minimum 3 quotes must be there...",
                                              icon: Icon(
                                                Icons.warning,
                                                color: Colors.yellow,
                                              ),
                                            );
                                          } else {
                                            if (await MyCloudFireStore
                                                .deleteQuote(
                                              deleteFromWhere:
                                                  widget.searchType,
                                              docID: widget.docID,
                                            )) {
                                              Get.back();
                                              MySnakBar(
                                                tital: "Success",
                                                message:
                                                    "This quote deleted : " + t,
                                                icon: Icon(
                                                  FontAwesomeIcons.check,
                                                  color: Colors.green,
                                                ),
                                              );
                                            }
                                            widget.myCallBack();
                                          }
                                        },
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () async {
                                        UploadQuote uploadQuote = UploadQuote(
                                          image: widget.image,
                                          quote: widget.quote,
                                          quote_category: "",
                                          time: DateTime.now()
                                              .millisecondsSinceEpoch,
                                          uid: "",
                                          searchType: "favorite",
                                        );
                                        myScreenOverlay(
                                            context: context, message: "");
                                        if (await MyCloudFireStore.uploadQuote(
                                          uploadQuote: uploadQuote,
                                        )) {
                                          Get.back();
                                          MySnakBar(
                                            tital: "Success",
                                            message: "Quote added in favorite",
                                            icon: Icon(
                                              FontAwesomeIcons.check,
                                              color: Colors.green,
                                            ),
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.star),
                                      iconSize: 35,
                                      color: Colors.amber,
                                    ),
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
