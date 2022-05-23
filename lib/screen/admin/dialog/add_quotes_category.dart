import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/firebase/storage/real_firebase.dart';
import 'package:quotes/model/quotes_category.dart';

class AddQuotesCategory extends StatefulWidget {
  AddQuotesCategory({Key? key}) : super(key: key);

  @override
  State<AddQuotesCategory> createState() => _AddQuotesCategoryState();
}

class _AddQuotesCategoryState extends State<AddQuotesCategory> {
  int l = 1;

  late String cname;
  Set sURL = {};

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add New Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: Colors.grey[700],
                  child: Text(
                    "Category :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                // Text(""),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: "Add New Category",
                    label: Text("Add New Category"),
                    prefixIcon: Icon(Icons.list),
                    border: UnderlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val != null) {
                      return null;
                    }
                    return "Enter Category";
                  },
                  onSaved: (val) {
                    if (val != null) {
                      cname = val;
                    }
                  },
                ),
                SizedBox(height: 10),
                // Text("Image URL"),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: Colors.grey[700],
                  child: Text(
                    "Image URL :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                for (int i = 1; i <= l; i++)
                  TextFormField(
                    textInputAction:
                        i == l ? TextInputAction.done : TextInputAction.next,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      hintText: "Add URL",
                      label: Text("Add URL"),
                      prefixIcon: Icon(Icons.list),
                      border: UnderlineInputBorder(),
                    ),
                    validator: (val) {
                      if (val != null && GetUtils.isURL(val)) {
                        return null;
                      }
                      return "Invalid url";
                    },
                    onSaved: (val) {
                      if (val != null) {
                        sURL.add(val);
                      }
                    },
                  ),
                // Column(
                //   children: iList.map((e) => e).toList(),
                // ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            if (l > 1) {
                              l--;
                            }
                          },
                        );
                      },
                      minWidth: 10,
                      // color: Colors.grey,
                      textColor: Colors.orangeAccent,
                      child: Icon(Icons.remove, size: 25),
                      shape: CircleBorder(),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(
                          () {
                            l++;
                          },
                        );
                      },
                      minWidth: 10,
                      // color: Colors.deepOrange,
                      textColor: Colors.deepOrange,
                      child: Icon(Icons.add, size: 25),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      print("hello");
                      sURL.clear();
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print(cname);
                        print(sURL.toList());
                        QuotesCategory qc = QuotesCategory(
                          // quotesCategoryName: "padsala",
                          // imageurl: [
                          //   "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
                          //   "https://cdn.pixabay.com/photo/2020/06/01/22/23/eye-5248678__340.jpg",
                          // ],
                          quotesCategoryName: cname.toLowerCase(),
                          imageurl: sURL.toList(),
                        );

                        if (await RealTimeDatabase.addCategory(qCat: qc)) {
                          Get.back();
                        }
                      }
                    },
                    child: const Text(
                      "ADD",
                      style: TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(Size(Get.width, 40))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
