import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PPrincipal.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
      //Se conecta con back4ap
  final keyApplicationId = 'nM1RCyRonJmydDakhBrLPQ5KMVusct3ngqG0Hi8B';
  final keyClientKey = 'nT22X3l7fDRJ1oI1UcElOCeaKnRNOSoTv44IwvFh';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences preferences = await SharedPreferences.getInstance();
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