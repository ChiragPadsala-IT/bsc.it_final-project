import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/screen/user_list_screen/component/user_card.dart';
import 'package:quotes/screen/user_list_screen/user_list_screen.dart';

class UserQuotes extends StatefulWidget {
  UserQuotes({Key? key}) : super(key: key);

  @override
  State<UserQuotes> createState() => _UserQuotesState();
}

class _UserQuotesState extends State<UserQuotes> {
  late Future<QuerySnapshot> _future;
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
  ];
  @override
  void initState() {
    _future = MyCloudFireStore.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: Colors.grey[700],
                child: Text(
                  "Quotes By User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(UserListScreen.path);
                },
                child: Text(
                  "view all >>",
                  style: TextStyle(
                    color: Colors.orange[300],
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Container(
            height: Get.width / 2,
            child: FutureBuilder(
              future: _future,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<QueryDocumentSnapshot> l1 = snapshot.data!.docs;
                  l1.forEach((element) => print(element.data()));
                  // print(data);
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: l1.length > 4 ? 4 : l1.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      Map data = l1[i].data() as Map;
                      return UserCard(
                        user: data["email"].toString(),
                        gradientColor: gradientColorList[i],
                        uID: data["uid"].toString(),
                      );
                    },
                    separatorBuilder: (context, i) {
                      return SizedBox(width: 10);
                    },
                  );
                }
                return MySpin();
              },
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     myCard(category: "Hello"),
          //     myCard(category: "Hello"),
          //   ],
          // ),
          // const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     myCard(category: "Hello"),
          //     myCard(category: "Hello"),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget myCard({required String category}) {
    return Container(
      height: 150,
      width: Get.width / 2.2,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        color: Colors.amber,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(3, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.black54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
