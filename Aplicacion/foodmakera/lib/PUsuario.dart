import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/QueryConversion.dart';
import 'Config/QueryConversion.dart';
import 'Config/QueryConversion.dart';
import 'Config/StringConsultas.dart';
import 'PRegistro.dart';
import 'PPerfil.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

List<User> activo;

class PUsuario extends StatefulWidget {
  final String title;
  PUsuario({Key key, this.title}) : super(key: key);
  _PUsuarioState createState() => _PUsuarioState();


}


class _PUsuarioState extends State<PUsuario> {
  Future<String> GetUssername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ussername = await preferences.getString('ussername');
    obtenerUsuario(ussername, activo);
    print(activo[0].descripcion);
    print(activo[0].correo);
    print(activo[0].username);
    print(activo[0].seguidores);
    print(activo[0].objectId);
    ParseUser user = await ParseUser.currentUser() as ParseUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    appBar: CustomAppBar(),
    body: Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    Text("Nombre:",
      style: TextStyle(
          fontWeight: FontWeight.bold
      ),
    ),
    SizedBox(height: 6,),
    Text(ussername, ),
    SizedBox(height: 16,),


    Text("Pais", style: TextStyle(
        fontWeight: FontWeight.bold
    ),
    ),
    SizedBox(height: 6,),
    Text("activo[0].pais"),
    SizedBox(height: 16,),

      Text("Descripcion", style: TextStyle(
          fontWeight: FontWeight.bold
      ),
      ),
      SizedBox(height: 6,),
      Text("activo[0].descripcion"),
      SizedBox(height: 16,),


    Divider(color: Colors.grey,)
    ],
    ),
    ),
    );
  }
}




class CustomAppBar extends StatelessWidget
    with PreferredSizeWidget{

  @override
  Size get preferredSize => Size(double.infinity, 320);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: Container(
        padding: EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
            color: Colors.lightGreen,
            boxShadow: [
              BoxShadow(
                  color: Colors.lightGreen,
                  blurRadius: 20,
                  offset: Offset(0, 0)
              )
            ]
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),

                Text("Perfil", style: TextStyle(
                  fontSize: 16,
                ),),

                IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white,),
                  onPressed: (){},
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
                              image: AssetImage("assets/perfil1.jpeg")
                          )
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text(ussername, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),)
                  ],
                ),

                Column(
                  children: <Widget>[
                    Text("Mis recetas", style: TextStyle(
                        color: Colors.white
                    ),),
                    Text("8", style: TextStyle(
                        fontSize: 26,
                        color: Colors.white
                    ),)
                  ],
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Column(
                  children: <Widget>[
                    Text("Seguidos", style: TextStyle(
                        color: Colors.white
                    ),),
                    Text("20K", style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),)
                  ],
                ),

                SizedBox(width: 32,),

                Column(
                  children: <Widget>[
                    Text("Seguidores",
                      style: TextStyle(
                          color: Colors.white
                      ),),
                    Text("activo[0].seguidores", style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ))
                  ],
                ),

                SizedBox(width: 16,)

              ],
            ),
            SizedBox(height: 8,),

            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (){
                  print("//TODO: button clicked");
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
                    child: Container(
                      width: 110,
                      height: 32,
                      child: Center(child: Text("Edit Profile"),),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20
                            )
                          ]
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
