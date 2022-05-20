import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:quotes/component/category_card.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/firebase/storage/real_firebase.dart';

class CategoryScreen extends StatefulWidget {
  static String path = "/category_screen";
  CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
        title: Text("Category"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _qcStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              DataSnapshot dataSnapshot = snapshot.data.snapshot;
              List<DataSnapshot> l = dataSnapshot.children.toList();
              List k = l.map((DataSnapshot e) => e.key).toList();

              print("*****************************************");
              print(dataSnapshot.child(k[0]).child("image").value);
              print("*****************************************");

              // imageListLenght = iURL.length;
              return Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: GridView.builder(
                  itemCount: k.length,
                  // itemCount: dataSnapshot.children.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, i) {
                    var iURl = dataSnapshot.child(k[i]).child("image").value;

                    return CategoryCard(category: k[i], imageURL: iURl);

                    // return InkWell(
                    //   // onLongPress: () async {
                    //   //   print(
                    //   //       "*****************chirag**************************");
                    //   //   setState(() async {
                    //   //     await RealTimeDatabase.deleteCategoryImage(
                    //   //       catName: widget.catName,
                    //   //       position:
                    //   //           dataSnapshot.children.elementAt(i).key.toString(),
                    //   //     );
                    //   //   });
                    //   //   print(
                    //   //       "***********************padsala********************");
                    //   // },
                    //   child: Container(
                    //     margin: EdgeInsets.all(15),
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey,
                    //       borderRadius: BorderRadius.circular(15),
                    //       // image: DecorationImage(
                    //       //   image: Image.network(
                    //       //     k[i],
                    //       //     // dataSnapshot.children
                    //       //     //     .elementAt(i)
                    //       //     //     .value
                    //       //     //     .toString(),
                    //       //   ).image,
                    //       //   fit: BoxFit.fill,
                    //       // ),
                    //     ),
                    //   ),
                    // );
                  },
                ),
              );
            }
          }
          return MySpin();
        },
      ),
    );
  }
}
