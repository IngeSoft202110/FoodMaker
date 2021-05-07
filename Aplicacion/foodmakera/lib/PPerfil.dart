import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print(ussername);
    return ussername;
  }

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
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            ussername= snapshot.data;
            return Column(
              children: [
                SizedBox(height: 30, width: 100, child: Text(ussername)),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
                        onPressed: () {},
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
}
