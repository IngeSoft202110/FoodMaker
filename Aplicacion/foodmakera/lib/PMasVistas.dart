

import 'package:flutter/material.dart';
import 'package:foodmakera/Pantallas/ListaRecetas.dart';
import 'Clases/Receta.dart';
import 'Config/StringConsultas.dart';
import 'Config/convertirQuery.dart';


List<Receta> todasRecetas=[];
class PMasVistas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => Estadosmasvistas();

}



class Estadosmasvistas extends State<PMasVistas>{
  @override
  Widget build(BuildContext context) {
    List<Receta> recetas=[];
    return FutureBuilder(
      future: buscaryTraerReceta(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          todasRecetas = [];
          return Center(child: Text("Error"));
          //Center(
          //  child: Text('Error: ${snapshot.hasError.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          todasRecetas = snapshot.data;
          return Listadinamica(todasRecetas);
        }
      },
    );
  }
}


Future<List<Receta>> buscaryTraerReceta() async {
  List<Receta> recetas = [];
  await obtenerRecetas(recetas, Consultas().buscarRecetasporvisitas);
  return recetas;
}