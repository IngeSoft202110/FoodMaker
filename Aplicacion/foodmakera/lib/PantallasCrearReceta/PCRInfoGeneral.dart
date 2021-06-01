
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Clases/Receta.dart';
import '../Config/convertirQuery.dart';
import 'PCRPrincipal.dart';

Receta recetaNueva;

LRecetas listRecetas = LRecetas(
  [],
  [],
);
bool variableNombre = true;

String nombre;
List<String> nomRecetas;

const uploadImage = r"""
mutation($file: Upload!) {
  upload(file: $file)
}
""";

TextEditingController controladorNombre = TextEditingController();
TextEditingController controladorDescripcion = TextEditingController();
TextEditingController controladorLink = TextEditingController();

class PCRInfoGeneral extends StatelessWidget{
  Receta receta;
  Verificar listaVerificar;
  PCRInfoGeneral(this.receta, this.listaVerificar);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstruccionCuerpo(context));
  }
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

class construccionBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoBody();
}

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

void validarNombre(){
  nombre = controladorNombre.text;
  print(nombre);
  nomRecetas = listRecetas.nrecetas;
  print(listRecetas.nrecetas.length);
  for (int i = 0; i < nomRecetas.length; i++){
    if (nomRecetas[i] == nombre){
      print("si existe" + nomRecetas[i]);
      listaVerificar.infoGeneral[0] = false;
    }
    else{
      print("no existe" + nomRecetas[i]);
      listaVerificar.infoGeneral[0] = true;
    }
  }
}

class LRecetas {
  LRecetas(
    this.recetas,
    this.nrecetas);

  List<Receta> recetas;
  List<String> nrecetas;
}