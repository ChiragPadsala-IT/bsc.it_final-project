import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/model/display_quote.dart';
import 'package:quotes/model/upload_quote.dart';
import 'package:quotes/model/user.dart';

class MyCloudFireStore {
  // GetStorage userGetStorage = GetStorage();
  // static CollectionReference user =
  //     FirebaseFirestore.instance.collection('user');
  // static CollectionReference quote =
  //     FirebaseFirestore.instance.collection('quotes');

  static final firebase = FirebaseFirestore.instance;

  static Future<QuerySnapshot> getUser() async {
    return await firebase.collection('user').get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getBestQuotes() {
    return firebase.collection('best_quotes').snapshots();
    // return user
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("best_quotes")
    //     .snapshots();
  }

  static Future<DocumentSnapshot> getUserData() async {
    return await firebase
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  // static Future<DocumentSnapshot> getQuotesCategory() async {
  //   return await user.doc(FirebaseAuth.instance.currentUser!.uid).get();
  // }

  static Future<bool> _hasUser({required MyUser myUser}) async {
    DocumentSnapshot documentSnapshot =
        await firebase.collection('user').doc(myUser.id).get();

    print(documentSnapshot.data());
    return documentSnapshot.data() == null ? true : false;
  }

  static Future<bool> addUser() async {
    User u = FirebaseAuth.instance.currentUser!;
    MyUser myUser = MyUser(id: u.uid, email: u.email!);
    print("*****************how*********************");
    try {
      if (await _hasUser(myUser: myUser)) {
        print("*****************are*********************");
        await firebase.collection('user').doc(myUser.id).set({
          'uid': myUser.id,
          'username': myUser.username,
          'phone': myUser.phone,
          'email': myUser.email,
          'country': myUser.country,
          'type': 'user',
          'time': DateTime.now().millisecondsSinceEpoch,
        });
        print("*****************you*********************");
        return true;
      } else {
        print("*****************error*********************");
        return true;
      }
    } on FirebaseStorage catch (err) {
      MySnakBar(
        message: err.bucket.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future<bool> editUser({required MyUser myUser}) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid.toString();
      await firebase.collection('user').doc(uid).update({
        'username': myUser.username,
        'phone': myUser.phone,
        'country': myUser.country,
      });

      return true;
    } on FirebaseStorage catch (err) {
      MySnakBar(
        message: err.bucket.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  static Future uploadQuote({
    required UploadQuote uploadQuote,
  }) async {
    print("******************hello********************");
    try {
      if (uploadQuote.searchType == "public") {
        print("*****************chirag*********************");
        await firebase.collection("quotes").doc().set({
          "image": uploadQuote.image,
          "quote": uploadQuote.quote,
          "quote_category": uploadQuote.quote_category,
          "time": uploadQuote.time,
          "uid": uploadQuote.uid,
        });
      } else if (uploadQuote.searchType == "private") {
        await firebase
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('private')
            .doc()
            .set({
          "image": uploadQuote.image,
          "quote": uploadQuote.quote,
          "quote_category": uploadQuote.quote_category,
          "time": uploadQuote.time,
          "uid": uploadQuote.uid,
        });
      } else if (uploadQuote.searchType == "favorite") {
        print("*****************padsala*********************");
        await firebase
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("favorite_quotes")
            .doc()
            .set({
          "image": uploadQuote.image,
          "quote": uploadQuote.quote,
          "time": uploadQuote.time,
        });
      } else if (uploadQuote.searchType == "quote_of_the_day") {
        await firebase.collection('quote_of_the_day').doc("special_quote").set({
          "image": uploadQuote.image,
          "quote": uploadQuote.quote,
          "time": uploadQuote.time,
        });
      } else if (uploadQuote.searchType == "slider_quotes") {
        await firebase.collection('best_quotes').doc().set({
          "image": uploadQuote.image,
          "quote": uploadQuote.quote,
          "time": uploadQuote.time,
        });
      }
      print("***************how are you***********************");
      return true;
    } on FirebaseException catch (err) {
      MySnakBar(
        tital: "Error",
        message: err.message.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }

  // static Stream<QuerySnapshot> getQuote({
  //   // required String matchType,
  //   // required String searchType,
  //   required DisplayQuote displayQuote,
  // }) {
  //   print("*************************hello*********************************");
  //   if (displayQuote.searchQuoteType == "category") {
  //     print("*************************chirag*********************************");
  //     return firebase
  //         .collection("quotes")
  //         .where("quote_category",
  //             isEqualTo: displayQuote.matchQuoteFeild.toUpperCase())
  //         // .orderBy('time', descending: true)
  //         .get()
  //         .asStream();
  //   } else if (displayQuote.searchQuoteType == "Favorite") {
  //     print(
  //         "****************************favorite********************************");
  //     return firebase
  //         .collection('user')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('favorite_quotes')
  //         .orderBy('time', descending: true)
  //         .get()
  //         .asStream();
  //   } else {
  //     print(
  //         "*************************padsala*********************************");
  //     print(displayQuote.matchQuoteFeild);
  //     return firebase
  //         .collection("quotes")
  //         .where("uid", isEqualTo: displayQuote.matchQuoteFeild)
  //         .get()
  //         .asStream();
  //   }
  // }

  static Future<QuerySnapshot> getQuote({
    // required String matchType,
    // required String searchType,
    required DisplayQuote displayQuote,
  }) async {
    print("*************************hello*********************************");
    if (displayQuote.searchQuoteType == "category") {
      print("*************************chirag*********************************");
      return await firebase
          .collection("quotes")
          .where("quote_category",
              isEqualTo: displayQuote.matchQuoteFeild.toUpperCase())
          // .orderBy('time', descending: true)
          .get();
      // .asStream();
    } else if (displayQuote.searchQuoteType == "favorite") {
      print(
          "****************************favorite********************************");
      return await firebase
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favorite_quotes')
          .orderBy('time', descending: true)
          .get();
      // .asStream();
    } else if (displayQuote.searchQuoteType == "user") {
      print(
          "*************************padsala*********************************");
      print(displayQuote.matchQuoteFeild);
      return await firebase
          .collection("quotes")
          .where("uid", isEqualTo: displayQuote.matchQuoteFeild)
          .get();
      // .asStream();
    } else if (displayQuote.searchQuoteType == "private") {
      return await firebase
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('private')
          .orderBy('time', descending: true)
          .get();
    } else if (displayQuote.searchQuoteType == "public") {
      return await firebase
          .collection('quotes')
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
    } else if (displayQuote.searchQuoteType == "quote_of_the_day") {
      return await firebase
          .collection("quote_of_the_day")
          .orderBy('time', descending: true)
          .get();
    } else if (displayQuote.searchQuoteType == "slider_quotes") {
      return await firebase
          .collection("best_quotes")
          .orderBy('time', descending: true)
          .get();
    } else {
      return await firebase
          .collection('quotes')
          .orderBy('time', descending: true)
          .get();
    }
  }

  static Future deleteQuote(
      {required String deleteFromWhere, required String docID}) async {
    try {
      if (deleteFromWhere == "public") {
        await firebase.collection("quotes").doc(docID).delete();
      } else if (deleteFromWhere == "private") {
        await firebase
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("private")
            .doc(docID)
            .delete();
      } else if (deleteFromWhere == "favorite") {
        await firebase
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('favorite_quotes')
            .doc(docID)
            .delete();
      } else if (deleteFromWhere == "slider_quotes") {
        await firebase.collection('best_quotes').doc(docID).delete();
      }
      return true;
    } on FirebaseStorage catch (err) {
      MySnakBar(
        message: err.bucket.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
      return false;
    }
  }
}
