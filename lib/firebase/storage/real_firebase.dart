import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quotes/component/snakbar.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:quotes/model/quotes_category.dart';
import 'package:quotes/model/upload_quote.dart';

class RealTimeDatabase {
  // final storage = FirebaseStorage.instance;
  // static final ref = FirebaseStorage.instance.ref();
  static DatabaseReference dbrf = FirebaseDatabase.instance.ref();

  static Stream<DatabaseEvent> getdata() {
    return dbrf.child("quotes_categories").onValue;
  }

  static Future getCategoryData() async {
    DataSnapshot dataSnapshot = await dbrf.child("quotes_categories").get();
    print("********************Hello chirag padsala***********************");
    List<DataSnapshot> dataList = dataSnapshot.children.toList();

    print("********************How are you?***********************");
    return dataList;
    // return await dbrf.child("quotes_categories").once();
  }

  static Future<bool> addCategory({required QuotesCategory qCat}) async {
    // dbrf.child("hello");
    print("*******************chirag*****************************");
    try {
      await dbrf
          .child("quotes_categories")
          .child(qCat.quotesCategoryName)
          .set({"image": qCat.imageurl});
      print("*******************padsala*****************************");
      return true;
    } on FirebaseException catch (err) {
      MySnakBar(
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future<bool> deleteCategory({required String qCat}) async {
    // dbrf.child("hello");
    print("*******************chirag*****************************");
    try {
      await dbrf.child("quotes_categories").child(qCat).remove();
      print("*******************padsala*****************************");
      return true;
    } on FirebaseException catch (err) {
      MySnakBar(
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Stream<DatabaseEvent> getCategoryImage({required String catName}) {
    return dbrf
        .child("quotes_categories")
        .child(catName)
        .child("image")
        .onValue;
  }

  static Future<void> addCategoryImage({
    required String catName,
    required List urlList,
    required String newURL,
  }) async {
    List l = [...urlList];
    l.add(newURL);
    try {
      await dbrf
          .child("quotes_categories")
          .child(catName)
          .child("image")
          .set(l);
    } on FirebaseException catch (err) {
      MySnakBar(
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      // return false;
    }
  }

  static Future<void> deleteCategoryImage({
    required String catName,
    // required List urlList,
    // required String newURL,
    required String position,
  }) async {
    try {
      await dbrf
          .child("quotes_categories")
          .child(catName)
          .child("image")
          .child(position)
          .remove();
    } on FirebaseException catch (err) {
      MySnakBar(
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      // return false;
    }
  }

  // static Future uploadQuote({required UploadQuote uploadQuote}) async {
  //   try {
  //     await dbrf.child("quotes").child(uploadQuote.time_stemp).set({
  //       "image": uploadQuote.image,
  //       "quote": uploadQuote.quote,
  //       "quote_category": uploadQuote.quote_category,
  //       "time_stemp": uploadQuote.time_stemp,
  //       "uid": uploadQuote.uid,
  //     });
  //     return true;
  //   } on FirebaseException catch (err) {
  //     showError(
  //       message: err.message.toString(),
  //       icon: const Icon(
  //         Icons.error,
  //         color: Colors.red,
  //       ),
  //     );
  //     return false;
  //   }
  // }

  // static void getd({required String category}) {
  //   print("********************hello*****************************");
  //   try {
  //     dbrf.child("quotes").onValue.where((event) {
  //       print("********************chirag*****************************");
  //       print(event.snapshot);
  //       return false;
  //     });
  //   } on FirebaseException catch (err) {
  //     showError(
  //       message: err.message.toString(),
  //       icon: const Icon(
  //         Icons.error,
  //         color: Colors.red,
  //       ),
  //     );
  //   }
  // }
}
