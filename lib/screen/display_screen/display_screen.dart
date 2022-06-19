import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/component/quote_card.dart';
import 'package:quotes/component/screen_overlay_load.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/model/display_quote.dart';
import 'package:quotes/model/upload_quote.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DisplayScreen extends StatefulWidget {
  static String path = "/quotes_screen";

  DisplayScreen({Key? key}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  DisplayQuote data = Get.arguments[0];
  late Future<QuerySnapshot> _future;
  // late Stream<QuerySnapshot> _stream;

  final _fkey = GlobalKey<FormState>();
  late String imageUrl;
  late String newQuote;
  TextEditingController quoteEditingController = TextEditingController();
  TextEditingController imageEditingController = TextEditingController();

  @override
  void initState() {
    // _stream = MyCloudFireStore.getQuote(displayQuote: data);
    _future = MyCloudFireStore.getQuote(displayQuote: data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        // title: data[1].toString == "category"
        //     ? Text(data[0].toString().toUpperCase())
        //     : Text(data[2].toString().split("@")[0].toUpperCase()),
        title: Text(data.title.toUpperCase()),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            // Map data = snapshot.data!.data() as Map<String, dynamic>;
            print(snapshot.data!.docs);
            List<QueryDocumentSnapshot> documentList = snapshot.data!.docs;
            documentList.forEach((element) => print(element.id));

            if (documentList.isNotEmpty) {
              return Stack(
                children: [
                  Container(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: documentList.length,
                      itemBuilder: (context, i) {
                        Map map = documentList[i].data() as Map;
                        String docID = data.searchQuoteType == "public" ||
                                data.searchQuoteType == "private" ||
                                data.searchQuoteType == "favorite" ||
                                data.searchQuoteType == "slider_quotes"
                            ? documentList[i].id
                            : "";
                        print(map);
                        return QuoteCard(
                          image: map["image"],
                          quote: map["quote"],
                          docID: docID,
                          searchType: data.searchQuoteType,
                          quoteLength: documentList.length,
                          myCallBack: () async {
                            setState(() {
                              _future =
                                  MyCloudFireStore.getQuote(displayQuote: data);
                            });
                          },
                        );
                      },
                    ),
                  ),
                  data.searchQuoteType != "slider_quotes"
                      ? Container()
                      : addQuoteAlert(totalQuote: documentList.length)
                ],
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://thumbs.dreamstime.com/b/emoticon-sorry-sign-vector-illustration-white-background-190484787.jpg",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "There is no quote...",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }
          return MySpin();
        },
      ),
    );
  }

  addQuoteAlert({required int totalQuote}) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          elevation: 10,
          focusElevation: 10,
          backgroundColor: Colors.orange[900],
          heroTag: "add slider quote",
          onPressed: () async {
            if (totalQuote < 6) {
              await Alert(
                context: context,
                title: "Add New Slide Quotes",
                closeIcon: null,
                content: Form(
                  key: _fkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: quoteEditingController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        maxLines: 10,
                        minLines: 2,
                        decoration: const InputDecoration(
                          hintText: "Enter Quote",
                          label: Text("Enter Quote"),
                          border: UnderlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.isNotEmpty && val.length > 10) {
                            return null;
                          }
                          return "There is more then 10 characters.";
                        },
                        onSaved: (val) {
                          newQuote = val!;
                        },
                      ),
                      TextFormField(
                        controller: imageEditingController,
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
                        onSaved: (val) {
                          imageUrl = val!;
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
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      if (_fkey.currentState!.validate()) {
                        _fkey.currentState!.save();

                        print(newQuote);
                        _fkey.currentState!.reset();
                        setState(() {});
                        Navigator.pop(context);
                      }

                      print("chirag");
                    },
                    width: 120,
                  ),
                ],
              ).show();

              UploadQuote uploadQuote = UploadQuote(
                image: imageUrl,
                quote: newQuote,
                quote_category: "",
                time: DateTime.now().millisecondsSinceEpoch,
                uid: "",
                searchType: "slider_quotes",
              );

              if (await MyCloudFireStore.uploadQuote(
                  uploadQuote: uploadQuote)) {
                setState(() {
                  _future = MyCloudFireStore.getQuote(displayQuote: data);
                });
                MySnakBar(
                  tital: "Success",
                  message: "New quote added successfully ...",
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  ),
                );
              }
            } else {
              MySnakBar(
                tital: "Warning",
                message: "No more then 6 quotes ...",
                icon: Icon(
                  Icons.warning,
                  color: Colors.yellow,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
