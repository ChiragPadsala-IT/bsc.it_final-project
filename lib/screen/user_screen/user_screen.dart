import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/dialog/edit_user.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/login/login_controller.dart';
import 'package:quotes/login/login_screen.dart';
import 'package:quotes/model/user.dart';
import 'package:quotes/screen/admin/quotes_category_screen.dart';

class UserScreen extends StatefulWidget {
  static String path = "/user_screen";
  UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<DocumentSnapshot> _fData;

  @override
  void initState() {
    _fData = MyCloudFireStore.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _fData,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height / 3,
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: Get.width / 15,
                                backgroundColor: Colors.white70,
                                child: Text(
                                  data["username"] == ""
                                      ? data["email"].toString()[0]
                                      : data["username"].toString()[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              data["username"] == ""
                                  ? Text(
                                      data["email"].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["username"],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          data["email"],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  const ListTile(
                    dense: true,
                    leading: Text(
                      "User Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 0,
                  ),
                  ListTile(
                    leading: const Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    title: Text(
                      data["email"],
                      textAlign: TextAlign.end,
                    ),
                    trailing: const Padding(
                      padding: EdgeInsets.only(left: 30, right: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: const Text(
                      "Phone",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    title: Text(
                      data["phone"] == "" ? "-" : data["phone"],
                      textAlign: TextAlign.end,
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.green[900],
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Text(
                      "Country",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    title: Text(
                      data["country"] == "" ? "-" : data["country"],
                      textAlign: TextAlign.end,
                    ),
                    trailing: const Padding(
                      padding: EdgeInsets.only(left: 30, right: 10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(
                          Icons.map,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  // SizedBox(height: 20),
                  data["type"] == "admin"
                      ? Column(
                          children: [
                            const ListTile(
                              dense: true,
                              leading: Text(
                                "Other",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Divider(height: 0),
                            ListTile(
                              onTap: () {
                                Get.toNamed(QuotesCategoryScreen.path);
                              },
                              leading: Text("Quotes Categories"),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                            Divider(),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            MyUser myUser = MyUser.Edit(
                              username: data["username"],
                              phone: data["phone"],
                              country: data["country"],
                            );
                            Get.dialog(EditUser(
                              myUser: myUser,
                              callBack: () {
                                setState(() {
                                  _fData = MyCloudFireStore.getUserData();
                                });
                              },
                            ));
                          },
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            minimumSize: MaterialStateProperty.all(
                              Size(Get.width / 3.5, 2),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (await Get.put(LoginController()).logout()) {
                              Get.offAllNamed(LoginScreen.path);
                            }
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, letterSpacing: 1),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            minimumSize: MaterialStateProperty.all(
                              Size(Get.width / 3.5, 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return MySpin();
          }
        },
      ),
    );
  }
}
