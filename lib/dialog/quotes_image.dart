import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/firebase/storage/real_firebase.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuotesImage extends StatefulWidget {
  final String catName;

  const QuotesImage({Key? key, required this.catName}) : super(key: key);

  @override
  State<QuotesImage> createState() => _QuotesImageState();
}

class _QuotesImageState extends State<QuotesImage> {
  late Stream _qiStream;
  final _fkey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    setState(() {
      _qiStream = RealTimeDatabase.getCategoryImage(catName: widget.catName);
    });
    super.initState();
  }

  List imageURL = [];
  // late int imageListLenght;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catName.toUpperCase()),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _qiStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              DataSnapshot dataSnapshot = snapshot.data.snapshot;
              List<DataSnapshot> l = dataSnapshot.children.toList();
              List imageList = l.map((e) => e.value).toList();
              print(imageList);
              // print(dataSnapshot.value);
              // List iURL = dataSnapshot.value as List;
              // print(iURL);
              // print(dataSnapshot.children.elementAt(1).key);
              // imageURL = dataSnapshot.value as List;
              imageURL = imageList;

              print("*********************777777********************");
              print(imageList);
              print("*********************777777********************");
              // imageListLenght = iURL.length;
              return GridView.builder(
                itemCount: imageList.length,
                // itemCount: dataSnapshot.children.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onLongPress: () async {
                      print(
                          "*****************chirag**************************");
                      setState(() async {
                        await RealTimeDatabase.deleteCategoryImage(
                          catName: widget.catName,
                          position:
                              dataSnapshot.children.elementAt(i).key.toString(),
                        );
                      });
                      print(
                          "***********************padsala********************");
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: Image.network(
                            imageList[i],
                            // dataSnapshot.children
                            //     .elementAt(i)
                            //     .value
                            //     .toString(),
                          ).image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return MySpin();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Alert(
            context: context,
            title: "Add Image",
            closeIcon: null,
            content: Form(
              key: _fkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: textEditingController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.url,
                    maxLines: 10,
                    minLines: 2,
                    decoration: const InputDecoration(
                      hintText: "Add Image URL",
                      label: Text("Add Image URL"),
                      border: UnderlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val!.isNotEmpty && GetUtils.isURL(val)) {
                        return null;
                      }
                      return "Invalid URL";
                    },
                  ),
                ],
              ),
            ),
            buttons: [
              DialogButton(
                child: Text(
                  "Cancle",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  _fkey.currentState!.reset();
                  // textEditingController.clear();
                  Navigator.pop(context);
                },
                width: 120,
              ),
              DialogButton(
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  print("123");
                  print(imageURL);
                  print("456");
                  if (_fkey.currentState!.validate()) {
                    await RealTimeDatabase.addCategoryImage(
                      catName: widget.catName,
                      urlList: imageURL,
                      newURL: textEditingController.text,
                    );
                    _fkey.currentState!.reset();
                    // _qiStream = RealTimeDatabase.getCategoryImage(
                    //     catName: widget.catName);
                    // setState(() {});
                    Navigator.pop(context);
                  }
                },
                width: 120,
              ),
            ],
          ).show();
        },
        child: Icon(Icons.add),
        heroTag: "image_add",
      ),
    );
  }
}
