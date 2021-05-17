import 'package:flutter/material.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'PRegistro.dart';
import 'Pantallas/ListaRecetas.dart';
import 'Config/ClienteGraphQL.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PCambioNombre.dart';
import 'PCambioContrasena.dart';
import 'PEliminar.dart';


void conectarse() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Se conecta con back 4 app
  final keyApplicationId = 'QkiDaibHBqiqgEVFZnGbfHjBqsAHczeJvCeRSAOu';
  final keyClientKey = '2dMSqnGMfojqLYwslmfIL2f1DU80xrbdyCLvOx5H';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
}

class PCambioPerfil extends StatefulWidget{

  final String title;

  PCambioPerfil({Key key, this.title}): super (key: key);
  _PCambioPerfil createState() => _PCambioPerfil();
}



class _PCambioPerfil extends State <PCambioPerfil>
{
  final NombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('¿Que desea editar?'),
        ),
        body: Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: FlatButton(
                      onPressed: () {
                        /*Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PUsuario()));*/
                      },
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightGreen,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            size: 22,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Mi Descripcion")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: FlatButton(
                      onPressed: () {
                        /*Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PUsuario()));*/
                      },
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightGreen,
                      child: Row(
                        children: [
                          Icon(
                            Icons.flag_outlined,
                            size: 22,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Mi Pais")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PCambioNombre()));
                      },
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightGreen,
                      child: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 22,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Cambiar Nombre de usuario")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: FlatButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightGreen,
                      child: Row(
                        children: [
                          Icon(
                            Icons.fastfood,
                            size: 22,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Mis Recetas")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PCambioContrasena()));
                      },
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightGreen,
                      child: Row(
                        children: [
                          Icon(
                            Icons.vpn_key,
                            size: 22,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Cambiar Contraseña")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PEliminar()));
                      },
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.lightGreen,
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 22,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: Text("Eliminar perfil")),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ))),
            ],

        ))
    ;
  }
  void cambiar() async{
    ParseUser user = await ParseUser.currentUser() as ParseUser;
    user.set("username",NombreController.text.trim());
    ParseResponse response = await user.save();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('ussername');
    if(response.success)
    {
      print ("ok");
    }
    print("save: $user");

  }
}