
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PUsuario.dart';
import 'PRegistro.dart';
import 'PAjustes.dart';

class PPerfil extends StatefulWidget {
  final String title;
  PPerfil({Key key, this.title}) : super(key: key);
  _PPerfilState createState() => _PPerfilState();
}

String ussername = '';

class _PPerfilState extends State<PPerfil> {
  Future<String> GetUssername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ussername = await preferences.getString('ussername');
    
    return ussername;
  }

  bool isLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetUssername(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.hasError.toString());
            return Center(child: Text(snapshot.hasError.toString()));
          }
          if (!snapshot.hasData) {
            return Scaffold(
             body: Center(
               child: new RaisedButton(onPressed:(){
                 Navigator.push(
                     context,
                     new MaterialPageRoute(
                         builder: (context) => PRegistro()));
               },
               color: Colors.lightGreen,
               child: Text("Iniciar Sesión"),),
             ),
            );
          } else {
            ussername = snapshot.data;
            return Column(
              children: <Widget>[
                Text(ussername,
                style: TextStyle(
                  fontSize: 18
                ),
                ),
                SizedBox(
                    height: 115,
                    width: 115,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/perfil1.jpeg"),
                    )),
                //FotoPerfil();
                SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => PUsuario()));

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
                            Expanded(child: Text("Mi cuenta")),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => PAjustes()));
                        },
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.lightGreen,
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings,
                              size: 22,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: Text("Ajustes")),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ))),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: FlatButton(
                        onPressed: () {
                          doUserLogout();
                        },
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: Colors.lightGreen,
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 22,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(child: Text("Log Out")),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ))),
              ],
            );
          }
        });
  }

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

  void doUserLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('ussername');
    showSuccess("User was successfully logout!");
    setState(() {
      isLoggedIn = false;
    });
  }
}
