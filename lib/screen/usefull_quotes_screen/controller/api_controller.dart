import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  var dataList = [].obs;

  Future<dynamic> getUser() async {
    var url = Uri.parse("https://type.fit/api/quotes");
    var response = await http.get(url);

    print(response.statusCode);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      dataList.value = data.obs;
    } else {
      return response.body;
    }
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
