import 'package:flutter/material.dart';
import 'PRegistro.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PCambioPais extends StatefulWidget{

  final String title;

  PCambioPais({Key key, this.title}): super (key: key);
  _PCambioPais createState() => _PCambioPais();
}



class _PCambioPais extends State <PCambioPais>
{
  final NombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cambiar Pais'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                Center(
                  child: const Text('Ingrese su pais',
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
                      labelText: 'Pais'),
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
    user.set("pais",NombreController.text.trim());
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