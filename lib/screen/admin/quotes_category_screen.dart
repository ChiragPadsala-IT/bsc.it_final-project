import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/dialog/add_quotes_category.dart';
import 'package:quotes/dialog/quotes_image.dart';
import 'package:quotes/firebase/storage/real_firebase.dart';
import 'package:quotes/model/quotes_category.dart';

class QuotesCategoryScreen extends StatefulWidget {
  static String path = "/Quotes_category_screen";
  QuotesCategoryScreen({Key? key}) : super(key: key);

  @override
  State<QuotesCategoryScreen> createState() => _QuotesCategoryScreenState();
}

class _QuotesCategoryScreenState extends State<QuotesCategoryScreen> {
  late Stream _qcStream;

  @override
  void initState() {
    setState(() {
      _qcStream = RealTimeDatabase.getdata();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes Categories"),
      ),
      body: StreamBuilder(
        stream: _qcStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              DataSnapshot dataSnapshot = snapshot.data.snapshot;
              List<DataSnapshot> l = dataSnapshot.children.toList();
              List k = l.map((e) => e.key).toList();
              print(k);
              // List v = l.map((e) => ).toList();

              // dataSnapshot.child("chirag").value.toString();

              return ListView.builder(
                itemCount: l.length,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.dialog(QuotesImage(catName: k[i].toString()));
                      },
                      leading: Icon(Icons.category),
                      title: Text(k[i].toString().toUpperCase()),
                      trailing: IconButton(
                        onPressed: () async {
                          if (await RealTimeDatabase.deleteCategory(
                              qCat: k[i])) {
                            showError(
                              tital: "Success",
                              message: "Successfully deleted ...",
                              icon: const Icon(
                                Icons.add_task,
                                color: Colors.green,
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () async {
            Get.dialog(AddQuotesCategory());
            // QuotesCategory qCat = QuotesCategory(
            //     quotesCategoryName: "quotesCategoryName",
            //     imageurl: ["imageurl"]);
            // await RealTimeDatabase.addCategory(qCat: qCat);
          },
          heroTag: "qcat",
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
