import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodmakera/PCambioPerfil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Config/QueryConversion.dart';
import 'PPerfil.dart';
import 'package:foodmakera/Clases/User.dart';

List<User> activo=[];
User usuario;

class PUsuario extends StatefulWidget {
  final String title;
  PUsuario({Key key, this.title}) : super(key: key);
  _PUsuarioState createState() => _PUsuarioState();
}

Future<String> GetUssername() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  ussername = await preferences.getString('ussername');
  await obtenerUsuario(ussername, activo);
  usuario=activo[0];
  print(activo[0].descripcion);
  print(activo[0].correo);
  print(activo[0].username);
  print(activo[0].seguidores);
  print(activo[0].objectId);
  return activo[0].username;
}

class _PUsuarioState extends State<PUsuario> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: null,
        future: GetUssername(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(child: Text("Error"));
          }
          if (!snapshot.hasData) {
            print("retorna ${snapshot.data}");
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
                appBar: CustomAppBar(),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Nombre:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        ussername,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Pais",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(usuario.pais),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Descripcion",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(usuario.descripcion),
                      SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  ),
                ));
          }
        });
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: GetUssername(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.hasError.toString());
            return Center(child: Text("Error"));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ClipPath(
              child: Container(
                padding: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(color: Colors.lightGreen, boxShadow: [
                  BoxShadow(
                      color: Colors.lightGreen,
                      blurRadius: 20,
                      offset: Offset(0, 0))
                ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          "Perfil",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(foto(ussername)))),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              ussername,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Mis recetas",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Seguidos",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "20K",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        SizedBox(
                          width: 16,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => PCambioPerfil()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                          child: Container(
                            width: 110,
                            height: 32,
                            child: Center(
                              child: Text("Editar perfil"),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 20)
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
