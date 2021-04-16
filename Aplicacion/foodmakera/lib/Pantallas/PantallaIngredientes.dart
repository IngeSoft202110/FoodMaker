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
IngredientesDinamico ingred=IngredientesDinamico();
TextEditingController controladortext = TextEditingController();

class pantallasi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return PantallaIngredientes();
  }
  pantalaya(BuildContext context) async{
    await traerIngredientes();
    return showDialog(context: context, builder:(context){
      return PantallaIngredientes();
    });
  }
}

class PantallaIngredientes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoAlert();
}



class estadoAlert extends State<PantallaIngredientes>{
  @override
  String inutil='';
  Widget build(BuildContext context) {
          return AlertDialog(
              scrollable: true,
              titlePadding: EdgeInsets.all(0.0),
              title: barraBusqueda(),
              content:
              Column(children: <Widget>[IngredientesDinamico()]));
        }

  Widget barraBusqueda() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            controladortext.clear();
            buscar(controladortext, ingred);
          });
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
              onChanged: (inutil){
                controladortext.text=inutil;
                controladortext.selection=(TextSelection.fromPosition(TextPosition(offset: inutil.length)));
                setState(() {
                  buscar(controladortext, ingred);
                });
              },
              onEditingComplete: () {
                setState(() {
                  buscar(controladortext, ingred);
                });
              },
              style: TextStyle(color: Colors.black, fontSize: 18),
              cursorColor: Colors.black,
              autofocus: true,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))
              ),
            )),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search,color: Colors.black),
        )
      ],
    );
  }
  }

buscar(TextEditingController control, IngredientesDinamico ingre) {
  List<String> resultados=List<String>();
  String buscar=control.text.toString().toLowerCase();
  String auxiliar;
  if (control.text.isNotEmpty){
    nombreIngredientes.forEach((element) {
      auxiliar=element;
      element=element.toLowerCase();
      if(element.contains(buscar)){
        resultados.add(auxiliar);
      }
    });
    IngredientesDinamico.listaCrear=resultados;
    ingre=IngredientesDinamico();
  }else{
    IngredientesDinamico.listaCrear=nombreIngredientes;
    ingre=IngredientesDinamico();
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
      labels: IngredientesDinamico.listaCrear,
      onSelected: (List auxseleccion) => setState(() {
          controladortext.clear();
          buscar(controladortext, ingred);
        auxseleccion = auxseleccion;
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
    IngredientesDinamico.listaCrear=nombres;
  }
}

List<String> stringingredientes() {
  List<String> nombres = List<String>();
  for (int i = 0; i < ingredientes.length; i++) {
    nombres.add(ingredientes[i].nombre);
  }
}