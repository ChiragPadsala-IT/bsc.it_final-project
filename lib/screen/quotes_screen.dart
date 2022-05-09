import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes/component/quote_card.dart';

class QuotesScreen extends StatefulWidget {
  static String path = "/quotes_screen";

  QuotesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Title"),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return QuoteCard();
        },
      ),
    );
  }
}
