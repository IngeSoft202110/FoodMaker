import 'package:flutter/material.dart';
import 'PPrincipal.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Maker',
      theme: ThemeData(primarySwatch: Colors.lightGreen,),
      home: PPrincipal(),
    );
  }
}