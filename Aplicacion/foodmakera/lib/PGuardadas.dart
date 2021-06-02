import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Clases/Receta.dart';
import 'Clases/User.dart';
import 'Config/QueryConversion.dart';
import 'PRegistro.dart';
import 'Pantallas/ListaRecetas.dart';

User usuario;
List<Receta> todasRecetas=[];
Future<User>traerUsuario() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = await preferences.getString('ussername');
  List<User> activo = [];
  await obtenerUsuario(username, activo);
  if (activo != null && activo.length > 0) {
    await obtenerRecetasG(todasRecetas,recetasGuardadas(activo[0].objectId));
    return activo[0];
  } else {
    return null;
  }
}


class PGuardadas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Estadosmasguardas();

}



class Estadosmasguardas extends State<PGuardadas>{
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
          usuario = snapshot.data;
          if(todasRecetas.length == 0 || todasRecetas == null){
            return Center(child: Text('No tiene recetas guardadas'));
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
