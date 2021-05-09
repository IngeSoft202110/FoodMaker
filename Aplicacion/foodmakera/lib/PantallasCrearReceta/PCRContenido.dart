import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Clases/Dieta.dart';
import '../Clases/Receta.dart';
import '../Clases/Region.dart';
import '../Clases/Tipo.dart';
import '../Clases/Utensilio.dart';
import '../Config/QueryConversion.dart';
import '../PBuscarRecetas.dart';

Atributos todosAtributos = Atributos(
    List<Dieta>(),
    List<String>(),
    List<Tipo>(),
    List<String>(),
    List<Region>(),
    List<String>(),
    List<Utensilio>(),
    List<String>());
String seleccionDieta;
String seleccionTipo;
String seleccionRegion;
String seleccionUtensilio;



class PCRContenido extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstruccionCuerpo(context));
  }
}

FutureBuilder ConstruccionCuerpo(BuildContext context) {
  return FutureBuilder(
      future: buscarInfo(todosAtributos),
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
            'Región de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione la región de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.nregion.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      Center(
          child: Text(
            'Tipo de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el tipo de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.ntipos.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      Center(
          child: Text(
            'Dieta de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione la dieta de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.ndietas.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      Center(
          child: Text(
            'Utensilio de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el utensilio de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.nutensilios.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
    ]);
  }
}

Future<Atributos> buscarInfo(Atributos todosAtributos) async {
  await buscarTipos(todosAtributos.tipos, todosAtributos.ntipos);
  await buscarRegiones(todosAtributos.regiones, todosAtributos.nregion);
  await buscarDietas(todosAtributos.dietas, todosAtributos.ndietas);
  await buscarUtensilios(todosAtributos.utensilios, todosAtributos.nutensilios);
  return todosAtributos;
}

void buscarTipos(List<Tipo> tipos, List<String> ntipos) async {
  await obtenerTipo(tipos);
  for (int i = 0; i < tipos.length; i++) {
    ntipos.add(tipos[i].nombre);
  }
}

void buscarRegiones(List<Region> regiones, List<String> nregion) async {
  await obtenerRegiones(regiones);
  for (int i = 0; i < regiones.length; i++) {
    nregion.add(regiones[i].nombre);
  }
}

void buscarDietas(List<Dieta> dietas, List<String> ndietas) async {
  await obtenerDietas(dietas);
  for(int i = 0; i < dietas.length; i++){
    ndietas.add(dietas[i].nombre);
  }
}

void buscarUtensilios(List<Utensilio> utensilios, List<String> nutensilios) async {
  await obtenerUtensilios(utensilios);
  for (int i = 0; i < utensilios.length; i++) {
    nutensilios.add(utensilios[i].nombre);
  }
}

class Atributos {
  Atributos(
      @required this.dietas,
      @required this.ndietas,
      @required this.tipos,
      @required this.ntipos,
      @required this.regiones,
      @required this.nregion,
      @required this.utensilios,
      @required this.nutensilios);

  List<Dieta> dietas;
  List<String> ndietas;
  List<Tipo> tipos;
  List<String> ntipos;
  List<Region> regiones;
  List<String> nregion;
  List<Utensilio> utensilios;
  List<String> nutensilios;
}