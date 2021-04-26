import 'package:flutter/material.dart';
import 'PPrincipal.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      //Se conecta con back4ap
  final keyApplicationId = 'yC5PSjDttvVvIkpBOWaHUZYo6lIHxQFKxwFD6ydT';
  final keyClientKey = 'TI3txrhBGDTlkHNtpyfdODfhoNLDcJF2wdKGfPY7';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
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