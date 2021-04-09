import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Config/Consultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'Config/ClienteGraphQL.dart';

List<String> seleccion = List<String>();
List<String> auxseleccion = List<String>();
List<Ingrediente> ingredientes =List<Ingrediente>();
List<String> nombreIngredientes = List<String>();
QueryResult querys = QueryResult();

class pantallaIngredientes extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return crearPantalla(context);
  }

  crearPantalla(BuildContext context) {
    traerIngredientes();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            titlePadding: EdgeInsets.all(0.0),
            title: AppBar(
              leading: IconButton(
                icon: Icon(Icons.clear),
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
              ],
            ),
            content: Column(
                  children:<Widget> [
                    IngredientesDinamico()
                  ]),
          );
        });
  }
}

class IngredientesDinamico extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => estadoDinamico();

}

class estadoDinamico extends State<IngredientesDinamico> {
  @override
  Widget build(BuildContext context) {
    return CheckboxGroup(
      labels: nombreIngredientes,
      onSelected: (List selected) =>
          setState(() {
            auxseleccion = selected;
          }),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final nombreIngredientes= stringingredientes();
  final recientes=[
    "Papas"
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = " ";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
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
  } else if(results.data.isNotEmpty){
    List respuesta = results.data['ingredientes']['edges'];
    for(int i=0; i < respuesta.length; i++){
      Ingrediente ingrediente= Ingrediente(
          respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_ingrediente'],
          respuesta[i]['node']['nombre']
      );
      ingrediente.medida=respuesta[i]['node']['medida'];
      nombres.add(respuesta[i]['node']['nombre']);
      ingre.add(ingrediente);
    }
    nombreIngredientes=nombres;
    ingredientes = ingre;
    querys=results;
  }
}


List<String> stringingredientes() {
  List<String> nombres = List<String>();
  for (int i = 0; i < ingredientes.length; i++) {
    nombres.add(ingredientes[i].nombre);
  }
}

