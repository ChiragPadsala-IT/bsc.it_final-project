import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/firebase/storage/real_firebase.dart';
import 'package:quotes/screen/quote_write/image_select_dialog.dart';

class QuoteWriteScreen extends StatefulWidget {
  static String path = "/quote_write_screen";
  QuoteWriteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteWriteScreen> createState() => _QuoteWriteScreenState();
}

class _QuoteWriteScreenState extends State<QuoteWriteScreen> {
  final _formkey = new GlobalKey<FormState>();

  String catName = "Select Category";
  late String quote;

  late Future _category;
  bool isCat = false;
  List<DataSnapshot> dataList = [];
  // List<Widget> t = [];
  int _radioGroup = 0;

  bool isDone = false;

  @override
  void initState() {
    // _categoryStream = RealTimeDatabase.getdata();
    super.initState();
  }

  Future getCategory() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write new quote"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 20, bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: Colors.grey[700],
                child: Text(
                  "Select Category",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              (isDone && catName == "Select Category")
                  ? Text("Error")
                  : Material(),
              ExpansionTile(
                title: Text(catName.toUpperCase()),
                leading: Icon(Icons.list),
                children: isCat == false
                    ? [MySpin()]
                    : dataList.map(
                        (DataSnapshot e) {
                          var t = e;
                          // print(e.child("image").children.elementAt(0).key);
                          return ListTile(
                            title: Text(e.key.toString().toUpperCase()),
                            leading: Icon(Icons.list_alt),
                            trailing: Container(
                              height: 30,
                              width: 30,
                              color: Colors.amber,
                              // decoration: BoxDecoration(
                              //     image: DecorationImage(
                              //   image: NetworkImage(""),
                              // )),
                            ),
                            onTap: () {
                              setState(() {
                                catName = e.key.toString();
                              });
                              isCat = true;
                            },
                          );
                        },
                      ).toList(),
                onExpansionChanged: (val) async {
                  if (val) {
                    if (true) {
                      dataList = await RealTimeDatabase.getCategoryData();
                      print(dataList);
                      setState(() {
                        isCat = true;
                      });
                    }
                  } else {}
                },
              ),
              Divider(),
              // Divider(),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                color: Colors.grey[700],
                child: Text(
                  "Write Quote",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                          hintText: "Write Quote",
                          label: Text("Write Quote"),
                          prefixIcon: Icon(FontAwesomeIcons.pencil),
                          border: UnderlineInputBorder(),
                        ),
                        validator: (val) {
                          if (val!.isEmpty || val.length <= 10) {
                            return "more then 10 characters";
                          } else if (val.length >= 100) {
                            return "less then 100 characters";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          if (val != null) {
                            quote = val;
                          }
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        color: Colors.grey[700],
                        child: Text(
                          "Select Type",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      RadioListTile(
                        value: 0,
                        groupValue: _radioGroup,
                        title: Text("Public"),
                        onChanged: (val) {
                          setState(() {
                            _radioGroup = int.parse(val.toString());
                          });
                        },
                      ),
                      RadioListTile(
                        value: 1,
                        groupValue: _radioGroup,
                        title: Text("Private"),
                        onChanged: (val) {
                          setState(() {
                            _radioGroup = int.parse(val.toString());
                          });
                        },
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _formkey.currentState!.reset();
                        catName = "Select Category";
                        isCat = false;
                        _radioGroup = 0;
                      });
                    },
                    child: Text("Reset"),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width / 4, 40),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isDone = true;
                      });

                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        print(catName);
                        print(quote);

                        Get.dialog(
                          ImageSelectDialog(
                            catName: catName,
                            quote: quote,
                            type: _radioGroup == 0 ? "public" : "private",
                          ),
                        );
                      }
                    },
                    child: Text("DONE"),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width / 4, 40),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget mycat() {
  //   return StreamBuilder(
  //     stream: _categoryStream,
  //     builder: (context, AsyncSnapshot snapshot) {
  //       return Text("data");
  //     },
  //   );
  // }
}
