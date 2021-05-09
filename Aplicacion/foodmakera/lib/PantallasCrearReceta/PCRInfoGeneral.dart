
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Clases/Receta.dart';
import '../Config/QueryConversion.dart';
import '../Config/convertirQuery.dart';

Receta recetaNueva = Receta.vacia();

LRecetas listRecetas = LRecetas(
  List<Receta>(),
  List<String>(),
);

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

AlertaError(BuildContext context, String texto) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Mensaje de Alerta"),
        content: new Text(texto),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'))
        ],
      )
  );
}



class LRecetas {
  LRecetas(
    @required this.recetas,
    @required this.nrecetas);

  List<Receta> recetas;
  List<String> nrecetas;
}