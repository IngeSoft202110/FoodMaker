import 'package:flutter/material.dart';
import 'PRegistro.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PEliminar extends StatefulWidget{

  final String title;

  PEliminar({Key key, this.title}): super (key: key);
  _PEliminar createState() => _PEliminar();
}



class _PEliminar extends State <PEliminar>
{
  final NombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eliminar Cuenta'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Center(
                  child: const Text('¿Está seguro que desea eliminar su cuenta?',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: const Text('Una vez eliminada su cuenta no podrá recuperarla',
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 16,
                ),

                SizedBox(
                  height: 8,
                ),

                SizedBox(
                  height: 8,
                ),

                SizedBox(
                  height: 8,
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Eliminar'),
                    onPressed: (){
                      cambiar();
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => PRegistro()));
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
  void cambiar() async{
    ParseUser user = await ParseUser.currentUser() as ParseUser;
    user.delete();
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