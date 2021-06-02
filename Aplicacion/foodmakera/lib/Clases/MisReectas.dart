import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:foodmakera/Pantallas/ListaRecetas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../PRegistro.dart';


User usuario;
List<Receta> todasRecetas=[];
Future<User>traerUsuario() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = await preferences.getString('ussername');
  List<User> activo = [];
  await obtenerUsuario(username, activo);
  if (activo != null || activo.length > 0) {
    await obtenerRecetas(todasRecetas,recetashechas(activo[0].objectId));
    usuario=activo[0];
    return activo[0];
  } else {
    return null;
  }
}


class PMisRecetas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Estadosmisrecetas();

}



class Estadosmisrecetas extends State<PMisRecetas>{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: traerUsuario(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          usuario = null;
          return BotonIniciarSesion(context);
          //Center(
          //  child: Text('Error: ${snapshot.hasError.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //usuario = snapshot.data;
          if(todasRecetas.length == 0 || todasRecetas == null){
            return Center(child: Text('No tiene recetas hechas'));
          }
          return Listadinamica(todasRecetas);
        }
      },
    );
  }

}

BotonIniciarSesion(BuildContext context){
  return Center(
    child: ElevatedButton(
      child: Text('Iniciar Sesion'),
      onPressed:(){
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => PRegistro()));
      },
    ),
  );
}
