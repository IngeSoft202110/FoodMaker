import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/QueryConversion.dart';
import 'Config/QueryConversion.dart';
import 'Config/QueryConversion.dart';
import 'Config/StringConsultas.dart';
import 'PRegistro.dart';
import 'PPerfil.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


class PUsuario extends StatefulWidget {
  final String title;
  PUsuario({Key key, this.title}) : super(key: key);
  _PUsuarioState createState() => _PUsuarioState();

}

String a = '';
String ussername = '';
class _PUsuarioState extends State<PUsuario> {
  Future<String> GetUssername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ussername = await preferences.getString('ussername');
    ParseUser user = await ParseUser.currentUser() as ParseUser;
    a = user.get("username");
    print(a);


    return ussername;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Mi cuenta',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Center(
        child: Text(a),
        )
      );
  }

}