import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/myspin.dart';
import 'package:quotes/component/quote_card.dart';

import 'package:quotes/screen/usefull_quotes_screen/controller/api_controller.dart';

class UseFullQuotesScreen extends StatelessWidget {
  static String path = "/usefull_quotes_screen";
  const UseFullQuotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiController = Get.put(ApiController());

    return Scaffold(
      appBar: AppBar(
        title: Text("Usefull Quotes"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return apiController.dataList.isEmpty
              ? MySpin()
              : ListView.builder(
                  itemCount: apiController.dataList.length,
                  itemBuilder: (context, i) {
                    return QuoteCard(
                      image: "",
                      quote: apiController.dataList[i]["text"].toString(),
                      docID: "",
                      searchType: "",
                      quoteLength: 0,
                      myCallBack: () {},
                    );
                    // return Container(
                    //   height: 200,
                    //   margin: EdgeInsets.all(10),
                    //   color: Colors.amber,
                    //   child: Text(apiController.dataList[i]["text"].toString()),
                    // );
                  },
                );
        },
      ),
    );
  }
}
