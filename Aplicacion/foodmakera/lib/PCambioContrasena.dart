import 'package:flutter/material.dart';
import 'PRegistro.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';


void conectarse() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Se conecta con back 4 app
  final keyApplicationId = 'QkiDaibHBqiqgEVFZnGbfHjBqsAHczeJvCeRSAOu';
  final keyClientKey = '2dMSqnGMfojqLYwslmfIL2f1DU80xrbdyCLvOx5H';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
}

class PCambioContrasena extends StatefulWidget{

  final String title;

  PCambioContrasena({Key key, this.title}): super (key: key);
  _PCambioContrasena createState() => _PCambioContrasena();
}



class _PCambioContrasena extends State <PCambioContrasena>
{
  final NombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cambio Contraseña'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Center(
                  child: const Text('Ingresa su nueva contraseña',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: NombreController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Contraseña'),
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
                  child: FlatButton(
                    child: const Text('Cambiar'),
                    color: Colors.lightGreen,
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
    user.set("password",NombreController.text.trim());
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