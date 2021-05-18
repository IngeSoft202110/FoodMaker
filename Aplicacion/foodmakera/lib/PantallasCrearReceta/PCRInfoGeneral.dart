
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../Clases/Receta.dart';
import '../Config/convertirQuery.dart';

Receta recetaNueva = Receta.vacia();

LRecetas listRecetas = LRecetas(
  List<Receta>(),
  List<String>(),
);

const uploadImage = r"""
mutation($file: Upload!) {
  upload(file: $file)
}
""";

TextEditingController controladorNombre = TextEditingController();
TextEditingController controladorDescripcion = TextEditingController();
TextEditingController controladorLink = TextEditingController();

class PCRInfoGeneral extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstruccionCuerpo(context));
  }
}

class construccionBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoBody();
}

  //validarNombre(listRecetas.nrecetas, controladorNombe.text);

class EstadoBody extends State<construccionBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(
          child: Text(
            'Nombre de la receta: ',
            style: TextStyle(),
          )),
      TextField(
        controller: controladorNombre,
      ),
      Center(
          child: Text(
            'Descripción: ',
            style: TextStyle(),
          )),
      TextField(
        controller: controladorDescripcion,
      ),
      Center(
          child: Text(
            'Link del video (opcional): ',
            style: TextStyle(),
          )),
      TextField(
        controller: controladorLink,
      ),
      Center(
          child: Text(
            'Foto de la receta: ',
            style: TextStyle(),
          )
      ),
    ]);
  }
//validarNombre(listRecetas.nrecetas, controladorNombe.text);
}

FutureBuilder ConstruccionCuerpo(BuildContext context) {
  return FutureBuilder(
      future: buscarInfo(listRecetas),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          return construccionBody();
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return construccionBody();
        }
      });
}

Future<List<Receta>> buscarInfo(LRecetas listRecetas) async {
  await buscarRecetas(listRecetas.recetas, listRecetas.nrecetas);
  return listRecetas.recetas;
}

void buscarRecetas(List<Receta> recetas, List<String> nrecetas) async {
  await obtenerRecetas(recetas);
  for (int i = 0; i < recetas.length; i++) {
    if (nrecetas.indexOf(recetas[i].Nombre) == -1) {
      nrecetas.add(recetas[i].Nombre);
    }
  }
}

bool validarNombre(List<String> nrecetas, String nombre){
  for (int i = 0; i < nrecetas.length; i++){
    if (nrecetas[i] == nombre){
      return true;
    }
  }
  return false;
}

class LRecetas {
  LRecetas(
    @required this.recetas,
    @required this.nrecetas);

  List<Receta> recetas;
  List<String> nrecetas;
}