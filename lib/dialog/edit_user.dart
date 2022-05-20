import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/firebase/storage/cloud_firestore.dart';
import 'package:quotes/model/user.dart';

class EditUser extends StatelessWidget {
  final MyUser myUser;
  final VoidCallback callBack;

  EditUser({Key? key, required this.myUser, required this.callBack})
      : super(key: key);

  final _formkey = GlobalKey<FormState>();

  late String username;
  late String phone;
  late String country;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit"),
        centerTitle: true,
        // elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: myUser.username,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Enter Username",
                  label: Text("Enter Username"),
                  prefixIcon: Icon(Icons.person),
                  border: UnderlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || GetUtils.isUsername(val)) {
                    return null;
                  }
                  return "Invalid username";
                },
                onSaved: (val) {
                  if (val != null) {
                    username = val;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: myUser.phone,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: "Enter Phone number",
                  label: Text("Enter Phone number"),
                  prefixIcon: Icon(Icons.phone),
                  border: UnderlineInputBorder(),
                ),
                validator: (val) {
                  if (val == null || val == "" || GetUtils.isPhoneNumber(val)) {
                    return null;
                  }
                  return "Invalid phone number";
                },
                onSaved: (val) {
                  if (val != null) {
                    phone = val;
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: myUser.country,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: "Enter Country Name",
                  label: Text("Enter Country Name"),
                  prefixIcon: Icon(Icons.map),
                  border: UnderlineInputBorder(),
                ),
                onSaved: (val) {
                  if (val != null) {
                    country = val;
                  }
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        _formkey.currentState!.reset();
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey),
                        minimumSize: MaterialStateProperty.all(
                          Size(Get.width / 3.5, 2),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          _formkey.currentState!.reset();

                          MyUser user = MyUser.Edit(
                            username: username,
                            country: country,
                            phone: phone,
                          );

                          if (await MyCloudFireStore.editUser(myUser: user)) {
                            callBack();
                            Get.back();
                          }
                        }
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
