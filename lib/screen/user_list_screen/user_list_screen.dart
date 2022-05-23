import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/screen/user_list_screen/component/user_card.dart';

class UserListScreen extends StatefulWidget {
  static String path = "/user_list_screen";
  UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<QuerySnapshot> _future;
  int selectColor = -1;
  List gradientColorList = [
    [
      Colors.orangeAccent,
      Colors.redAccent,
    ],
    [
      Colors.indigoAccent,
      Colors.pinkAccent,
    ],
    [
      Colors.yellowAccent,
      Colors.pinkAccent,
    ],
    [
      Colors.greenAccent,
      Colors.yellowAccent,
    ],
    [
      Colors.green,
      Colors.lightBlueAccent,
    ],
    [
      Colors.white,
      Colors.deepOrangeAccent,
    ],
  ];

  @override
  void initState() {
    _future = MyCloudFireStore.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User List",
          // style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        // backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> l1 = snapshot.data!.docs;
              l1.forEach((element) => print(element.data()));
              // print(data);
              return GridView.builder(
                itemCount: l1.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, i) {
                  Map data = l1[i].data() as Map;
                  if (selectColor == 6) {
                    selectColor = -1;
                  }
                  selectColor++;
                  // print(data["uid"]);
                  return UserCard(
                    user: data["email"].toString(),
                    gradientColor: gradientColorList[i],
                    uID: data["uid"],
                  );
                  // return Container(
                  //   height: 150,
                  //   width: Get.width / 2.2,
                  //   alignment: Alignment.center,
                  //   margin: EdgeInsets.all(2),
                  //   padding: EdgeInsets.all(15),
                  //   decoration: BoxDecoration(
                  //     color: Colors.amber,
                  //     borderRadius: BorderRadius.circular(15),
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         color: Colors.black26,
                  //         offset: Offset(2, 2),
                  //         blurRadius: 5,
                  //       ),
                  //       BoxShadow(
                  //         color: Colors.black26,
                  //         offset: Offset(-1, -1),
                  //         blurRadius: 5,
                  //       ),
                  //     ],
                  //     gradient: LinearGradient(
                  //       begin: Alignment.topLeft,
                  //       end: Alignment.bottomRight,
                  //       colors: gradientColorList[i],
                  //     ),
                  //   ),
                  //   child: Text(
                  //     data["email"].toString().split("@")[0],
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  // );
                },
              );
            }
            return MySpin();
          },
        ),
      ),
    );
  }
}
