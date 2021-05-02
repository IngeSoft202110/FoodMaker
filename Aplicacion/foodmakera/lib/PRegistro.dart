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


void conectarse() async {
  WidgetsFlutterBinding.ensureInitialized();
       //Se conecta con back 4 app
  final keyApplicationId = 'sFm15UEvDih66Avq9sRoxCQ70ur9Qaq95FZDNG5T';
  final keyClientKey = 'gDslVEPCuWi6LfiQ20Hpi6kThkusPuTreZdBmHfT';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

   Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
}


class PRegistro extends StatefulWidget{

  final String title;

  PRegistro({Key key, this.title}): super (key: key);
  _PRegistroState createState() => _PRegistroState();
}



class _PRegistroState extends State <PRegistro>
{
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;
   //Pantalla para iniciar sesion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inicio de sesion'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 200,
                ),
                Center(
                  child: const Text('Iniciar Sesion',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child:
                  const Text('Ingrese usuario y contraseña', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
                  enabled: !isLoggedIn,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Username'),
                ),

                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  enabled: !isLoggedIn,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Login'),
                    onPressed: isLoggedIn ? null : () => doUserLogin(),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 50,
                  child: TextButton(
                    child: const Text('Logout'),
                    onPressed: !isLoggedIn ? null : () => doUserLogout(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
//Mensaje que indica si fue exitoso
  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//Mensaje de error
  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
//Funcion para hacer inicio de sesion
  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();
    final user = ParseUser(username, password, null);
    var response = await user.login();


    if (response.success) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('ussername', controllerUsername.text);
      showSuccess("User was successfully login!");
      setState(() {
        isLoggedIn = true;
      });
    } else {
      showError(response.error.message);
    }

  }
// Funcion para salir de la cuenta
  void doUserLogout() async {
        //Stand by, no la usamos por ahora
  }
}
