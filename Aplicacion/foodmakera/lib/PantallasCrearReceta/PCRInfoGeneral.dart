
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/RecetaCreacion.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Tipo.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import '../Clases/Receta.dart';
import '../Config/convertirQuery.dart';
import 'PCRPrincipal.dart';
import 'PantallaFoto.dart';

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
TextEditingController controladorDescripcion = TextEditingController(text: '');
TextEditingController controladorLink = TextEditingController();
TextEditingController tiempo = TextEditingController(text: '0');

class PCRInfoGeneral extends StatelessWidget{
  Verificar listaVerificar;
  PCRInfoGeneral(this.listaVerificar);
  @override
  Widget build(BuildContext context) {
    if(recetaCreacion.recetac  == null){
      recetaCreacion.recetac=Receta.DB(Dieta.vacia(), Region.vacio(), Tipo.vacio(), [], "", "", "", 0, 0, [], [], "", User.vacio(), []);
    }
    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(20), child: ConstruccionCuerpo(context)));
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
      SizedBox(
        height: 20,
      ),
      Center(
          child: Text(
            'Descripción: ',
            style: TextStyle(),
          )),
      TextField(
        controller: controladorDescripcion,
        decoration: InputDecoration(border: OutlineInputBorder())
      ),
      /*Center(
          child: Text(
            'Link del video (opcional): ',
            style: TextStyle(),
          )),
      TextField(
        controller: controladorLink,
      ),*/
      SizedBox(
        height: 20,
      ),
      Center(
          child: Text(
            'Foto de la receta: ',
            style: TextStyle(),
          )
      ),
      Container(
        height: 120,
        width: 100,
        child:  foto(),
      ),
      ElevatedButton(
          onPressed: () {
            setState(() async {
              foto.Imagen = await DialogoFoto(context);
              recetaCreacion.recetac.foto = foto.Imagen;
            });
          },
          child: Text("Seleccionar foto de la receta")
      ),
      SizedBox(
        height: 20,
      ),
      Center(
          child: Text(
            '¿Cuánto tiempo en minutos dura la preparación de la receta?',
            style: TextStyle(),
          )),
      TextField(
        controller: tiempo,
      )
    ]);
  }
}

class foto extends StatefulWidget{
  @override
  static var Imagen;
  State<StatefulWidget> createState() => estadoFoto();
}

class estadoFoto extends State<foto> {
  @override
  Widget build(BuildContext context) {
    if (foto.Imagen != null) {
      return Image.file(foto.Imagen);
    } else {
      return Center(
        child: Text("Sin imagen"),
      );
    }
  }
}

Future<List<Receta>> buscarInfo(LRecetas listRecetas) async {
  await buscarRecetas(listRecetas.recetas, listRecetas.nrecetas);
  return listRecetas.recetas;
}

void buscarRecetas(List<Receta> recetas, List<String> nrecetas) async {
  await obtenerRecetas(recetas, Consultas().buscartodasRecetas);
  for (int i = 0; i < recetas.length; i++) {
    if (nrecetas.indexOf(recetas[i].Nombre) == -1) {
      nrecetas.add(recetas[i].Nombre);
    }
  }
}

void validarNombre(){
  nombre = controladorNombre.text;
  nomRecetas = listRecetas.nrecetas;
  print(listRecetas.nrecetas.length);
  listaVerificar.infoGeneral[0] = true;
  for (int i = 0; i < nomRecetas.length; i++){
    if (nomRecetas[i] == nombre){
      print("si existe" + nomRecetas[i]);
      listaVerificar.infoGeneral[0] = false;
    }
  }
  if(controladorDescripcion.text == ""){
    listaVerificar.infoGeneral[0] = false;
  }
  if(tiempo.text == "0"){
    listaVerificar.infoGeneral[0] = false;
  }
  if(foto.Imagen == null){
    listaVerificar.infoGeneral[0] = false;
  }
  if(listaVerificar.infoGeneral[0] == true){
    recetaCreacion.recetac.tiempo=int.parse(tiempo.text);
    recetaCreacion.recetac.Nombre = nombre;
    recetaCreacion.recetac.descripcion = controladorDescripcion.text;
    recetaCreacion.recetac.foto= foto.Imagen;
  }
}

class LRecetas {
  LRecetas(
    this.recetas,
    this.nrecetas);
  List<Receta> recetas;
  List<String> nrecetas;
}

void limpiarGeneral(){
  controladorNombre = TextEditingController(text: '');
  controladorDescripcion = TextEditingController(text: '');
  tiempo = TextEditingController(text: '0');
  foto.Imagen = null;
}