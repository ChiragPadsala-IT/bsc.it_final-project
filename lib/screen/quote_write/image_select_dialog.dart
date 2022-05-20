import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/firebase/storage/real_firebase.dart';
import 'package:quotes/model/upload_quote.dart';
import 'package:quotes/screen/home/home_screen.dart';

class ImageSelectDialog extends StatefulWidget {
  final String catName;
  final String quote;
  final String type;
  const ImageSelectDialog({
    Key? key,
    required this.catName,
    required this.quote,
    required this.type,
  }) : super(key: key);

  @override
  State<ImageSelectDialog> createState() => _ImageSelectDialogState();
}

class _ImageSelectDialogState extends State<ImageSelectDialog> {
  late Stream _qiStream;
  String _selectedImage = "";
  void initState() {
    print(widget.catName);
    print(widget.quote);
    print(widget.type);

    _qiStream = RealTimeDatabase.getCategoryImage(catName: widget.catName)
        .asBroadcastStream();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Image"),
        // centerTitle: true,
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              UploadQuote uploadQuote = UploadQuote(
                quote: widget.quote.toUpperCase(),
                quote_category: widget.catName.toUpperCase(),
                image: _selectedImage == "" ? "" : _selectedImage,
                time_stemp: DateTime.now().millisecondsSinceEpoch.toString(),
                uid: FirebaseAuth.instance.currentUser!.uid.toString(),
              );
              if (widget.type == "public") {
                if (await RealTimeDatabase.uploadQuote(
                    uploadQuote: uploadQuote)) {
                  Get.offAndToNamed(HomeScreen.path);
                }
              } else {
                print("Oops");
              }
            },
            icon: Icon(Icons.upload),
            label: Text("Upload"),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: Get.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              image: _selectedImage == ""
                  ? null
                  : DecorationImage(
                      image: NetworkImage(_selectedImage),
                      fit: BoxFit.fill,
                      colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
            ),
            child: Text(
              widget.quote,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height / 6,
              // color: Colors.amber,
              child: StreamBuilder(
                stream: _qiStream,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    DataSnapshot dataSnapshot = snapshot.data.snapshot;
                    List<DataSnapshot> l = dataSnapshot.children.toList();
                    List imageList = l.map((e) => e.value).toList();
                    print(imageList);
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: imageList.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedImage = imageList[i];
                            });
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            height: Get.width / 4,
                            width: Get.width / 4,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  color: Colors.black45,
                                  blurRadius: 5,
                                ),
                                BoxShadow(
                                  offset: Offset(-1, -1),
                                  color: Colors.black45,
                                  blurRadius: 5,
                                ),
                              ],
                              image: DecorationImage(
                                image: NetworkImage(imageList[i]),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
