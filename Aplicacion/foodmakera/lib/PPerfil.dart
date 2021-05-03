import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'Pantallas/ListaRecetas.dart';
import 'Config/ClienteGraphQL.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class PPerfil extends StatefulWidget{

  final String title;

  PPerfil({Key key, this.title}): super (key: key);
  _PPerfilState createState() => _PPerfilState();
}


class _PPerfilState extends State <PPerfil> {

  @override
  String ussername = '';

  Future GetUssername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ussername = await preferences.getString(('ussername'));
    print (ussername);

  }
  @override
  void initState(){
    super.initState();
    GetUssername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }


}




