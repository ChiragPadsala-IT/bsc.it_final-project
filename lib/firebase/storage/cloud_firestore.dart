import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes/component/snakbar.dart';
import 'package:quotes/model/user.dart';

class MyCloudFireStore {
  CollectionReference user = FirebaseFirestore.instance.collection('user');
  GetStorage userGetStorage = GetStorage();

  void addUser({required MyUser myuser}) async {
    try {
      await user.doc(userGetStorage.read('uid').to).set({
        'name': myuser.name,
        'phone': myuser.phone,
        'email': myuser.email,
        'country': myuser.country,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
    } on FirebaseStorage catch (err) {
      showError(
        message: err.bucket.toString(),
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }
}
