import 'package:flutter/material.dart';
import 'package:credit_card_flutter/credit_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body:
            ListView(
              padding: const EdgeInsets.all(12),
              children: const <Widget>[
                CreditCardForm()
              ],
            )
        )
    );
  }
}