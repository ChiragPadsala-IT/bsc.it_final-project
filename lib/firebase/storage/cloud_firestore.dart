import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/model/user.dart';

class MyCloudFireStore {
  // GetStorage userGetStorage = GetStorage();
  static CollectionReference user =
      FirebaseFirestore.instance.collection('user');

  static Stream<QuerySnapshot<Map<String, dynamic>>> getBestQuotes() {
    return user
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("best_quotes")
        .snapshots();
  }

  static Future<DocumentSnapshot> getUserData() async {
    return await user.doc(FirebaseAuth.instance.currentUser!.uid).get();
  }

  // static Future<DocumentSnapshot> getQuotesCategory() async {
  //   return await user.doc(FirebaseAuth.instance.currentUser!.uid).get();
  // }

  static Future<bool> _hasUser({required MyUser myUser}) async {
    DocumentSnapshot documentSnapshot = await user.doc(myUser.id).get();

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
        await user.doc(myUser.id).set({
          'id': myUser.id,
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
      showError(
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
      await user.doc(uid).update({
        'username': myUser.username,
        'phone': myUser.phone,
        'country': myUser.country,
      });

      return true;
    } on FirebaseStorage catch (err) {
      showError(
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
