import 'package:flutter/material.dart';
import 'Page1.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prueba',
      theme: ThemeData(primarySwatch: Colors.lightGreen,),
      home: Page1(),

    );

  }
}

