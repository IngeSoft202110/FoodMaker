import 'package:flutter/material.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'Pantallas/ListaRecetas.dart';
List<Receta> otrasr = [];


//Pantalla de inicio donde se mostraran las recetas
class PHome extends StatefulWidget{

  final String title;

  PHome({Key key, this.title}): super (key: key);
  _PHomeState createState () => _PHomeState();
}


class _PHomeState extends State <PHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: llenarRecetas(),
        initialData: null,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            otrasr = [];
            print(snapshot.hasError.toString());
            return Listadinamica(otrasr);
            //Center(
            //  child: Text('Error: ${snapshot.hasError.toString()}'));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            otrasr = snapshot.data;
            return Listadinamica(otrasr);
          }
        },
      ),
    );
  }
}
Future<List<Receta>> llenarRecetas() async {
  List<Receta> todas = [];
  await obtenerRecetas(todas, Consultas().buscartodasRecetas);
  return todas;
}