import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PCambioNombre.dart';
import 'PCambioContrasena.dart';
import 'PEliminar.dart';
import 'PCambioPais.dart';
import 'PCambioDescripcion.dart';


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
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PCambioDescripcion()));
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
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => PCambioPais()));
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
                          Expanded(child: Text("Mi nombre de usuario")),
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
                          Expanded(child: Text("Mi contraseña")),
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