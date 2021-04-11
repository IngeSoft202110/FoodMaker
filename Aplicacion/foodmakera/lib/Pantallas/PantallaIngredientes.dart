import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Config/Consultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:foodmakera/Config/ClienteGraphQL.dart';

List<String> auxseleccion = List<String>();
List<Ingrediente> ingredientes = List<Ingrediente>();
List<String> nombreIngredientes = List<String>();
List<String> auxCuandoBusca =List<String>();
QueryResult querys = QueryResult();



class PantallaIngredientes extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => estadoAlert();
}

class estadoAlert extends State<PantallaIngredientes> {
  @override
  Widget build(BuildContext context) {
    traerIngredientes();
    return Padding(
        padding: const EdgeInsets.all(0),
      child: mostrarDialogo()
      );
  }

  mostrarDialogo() {
    return showDialog(context: context,
        builder: (BuildContext context) {
        return AlertDialog(
            scrollable: true,
            titlePadding: EdgeInsets.all(0.0),
            title: _barraBusqueda(),
            content:
            Column(children: <Widget>[IngredientesDinamico()]));
      },
    );
  }
}




Widget _barraBusqueda() {
  final TextEditingController controladortext = TextEditingController();
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        controladortext.clear();
      },
    ),
    title:
    Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 5),
      child: SizedBox(
          width: 200,
          height: 35,
          child: TextField(
            textAlign: TextAlign.center,
            controller: controladortext,
            onEditingComplete: () {
              buscar(controladortext);
            },
            style: TextStyle(color: Colors.black, fontSize: 18),
            cursorColor: Colors.white,
            autofocus: true,
            decoration: InputDecoration(
                focusColor: Colors.white,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))
            ),
          )),
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          buscar(controladortext);
        },
      )
    ],
  );
}

buscar(TextEditingController control) {
  List<String> nose=['Primer','Segundo'];
  if (control.text.isNotEmpty){
    IngredientesDinamico.listaCrear=nombreIngredientes;
  }else{
    IngredientesDinamico.listaCrear=nose;
  }
}

class IngredientesDinamico extends StatefulWidget {
  static List<String> listaCrear;
  @override
  State<StatefulWidget> createState() => estadoDinamico();
}

class estadoDinamico extends State<IngredientesDinamico> {
  @override
  Widget build(BuildContext context) {
    return CheckboxGroup(
      labels: nombreIngredientes,
      onSelected: (List selected) => setState(() {
        auxseleccion = selected;
      }),
    );
  }
}


void traerIngredientes() async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  List<String> nombres = List<String>();
  List<Ingrediente> ingre = List<Ingrediente>();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarIngredientes)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['ingredientes']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Ingrediente ingrediente = Ingrediente(
          respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_ingrediente'],
          respuesta[i]['node']['nombre']);
      ingrediente.medida = respuesta[i]['node']['medida'];
      nombres.add(respuesta[i]['node']['nombre']);
      ingre.add(ingrediente);
    }
    nombreIngredientes = nombres;
    ingredientes = ingre;
    querys = results;
  }
}

List<String> stringingredientes() {
  List<String> nombres = List<String>();
  for (int i = 0; i < ingredientes.length; i++) {
    nombres.add(ingredientes[i].nombre);
  }
}
