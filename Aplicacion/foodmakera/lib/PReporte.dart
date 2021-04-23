
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'Clases/Receta.dart';
import 'Clases/Ingrediente.dart';
import 'Clases/Dieta.dart';
import 'Clases/Region.dart';
import 'Clases/Tipo.dart';
import 'Clases/Utensilio.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/Consultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

List<Receta> recetas = new List<Receta>();

class PReporte extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Food Maker',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Text('Nombre de la receta: '
            )
          ),
        ]
      ),
    );
  }
}

FutureBuilder nombresRecetas(BuildContext context){
  return FutureBuilder(future: obtenerRecetas(recetas),
    builder: (context, snapshot){
      if (snapshot.hasError) {
        return Center(
            child: Text('Error: ${snapshot.hasError.toString()}'));
      }
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        recetas=snapshot.data;
        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.hasError.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          recetas=snapshot.data;
        }
      }
    },
  );
}

