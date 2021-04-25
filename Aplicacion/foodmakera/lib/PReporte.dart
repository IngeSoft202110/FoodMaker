import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Clases/Dieta.dart';
import 'Clases/Ingrediente.dart';
import 'Clases/Receta.dart';
import 'Clases/Region.dart';
import 'Clases/Tipo.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/StringConsultas.dart';

Listado todosListado;
String seleccionreceta;
//------------------------------------------
List<Receta> recetas = new List<Receta>();
List<String> nrecetas = new List<String>();
//------------------------------------------
List<Dieta> dietas = new List<Dieta>();
List<String> ndietas = new List<String>();
//-----------------------------------------
List<Ingrediente> ingredientes = new List<Ingrediente>();
List<String> ningredientes = new List<String>();
//-----------------------------------------
List<Tipo> tipos = new List<Tipo>();
List<String> ntipos = new List<String>();
//-----------------------------------------
List<Region> regiones = new List<Region>();
List<String> nregion = new List<String>();
//----------------------------------------
List<Utensilio> utensilios = new List<Utensilio>();
List<String> nutensilios = new List<String>();

class PReporte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    nombresRecetas(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Food Maker',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: nombresRecetas(context)
    );
  }
}


class ListadoRecetas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoRecetas();
}

class estadoRecetas extends State<ListadoRecetas> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: seleccionreceta,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          seleccionreceta = newValue;
        });
      },
      items: todosListado.nrecetas
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

void buscarRecetas(List<Receta> recetas, List<String> nrecetas) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarNombreRecetas)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List ListaRespuestas = results.data['recetas']['edges'];
    for (int i = 0; i < ListaRespuestas.length; i++) {
      Receta nr = Receta.reporte(ListaRespuestas[i]['node']['objectId'],
          ListaRespuestas[i]['node']['nombre']);
      if(recetas.indexOf(nr) == -1){
        nrecetas.add(ListaRespuestas[i]['node']['nombre']);
        recetas.add(nr);
      }
    }
  }
}

//Hace el Query en la base de datos
void buscarIngredientes(
    List<Ingrediente> ingredientes, List<String> ningredientes) async {
  List<Ingrediente> ingre=List<Ingrediente>();
  List<String> ningre=List<String>();
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarIngredientes)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['ingredientes']['edges'];
    //Recorre toda las lista que dio el query para guardar los ingrdientes y sus nombres
    for (int i = 0; i < respuesta.length; i++) {
      Ingrediente ingrediente = Ingrediente(
          respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_ingrediente'],
          respuesta[i]['node']['nombre']);
      ningre.add(respuesta[i]['node']['nombre']);
      ingre.add(ingrediente);
    }
    ingredientes=ingre;
    ningredientes=ningre;
  }
}

void buscarDietas(List<Dieta> dietas, List<String> ndietas) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results =
      await cliente.query(QueryOptions(documentNode: gql(Consultas().query)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['dietas']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Dieta dieta = Dieta.Completa(respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_diente'], respuesta[i]['node']['nombre']);
      ndietas.add(respuesta[i]['node']['nombre']);
      dietas.add(dieta);
    }
  }
}

void buscarRegiones(List<Region> regiones, List<String> nregion) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarRegiones)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['regions']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Region region = Region.Completa(respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_region'], respuesta[i]['node']['nombre']);
      regiones.add(region);
      nregion.add(respuesta[i]['node']['nombre']);
    }
  }
}

void buscarTipos(List<Tipo> tipos, List<String> ntipos) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarTipos)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['tipos']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Tipo nd = Tipo.Completa(respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_tipo'], respuesta[i]['node']['nombre']);
      tipos.add(nd);
      ntipos.add(respuesta[i]['node']['nombre']);
    }
  }
}

void buscarUtensilios(
    List<Utensilio> utensilios, List<String> nutensilios) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarUtensilios)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['utensilios']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Utensilio utensilio = Utensilio(
          respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['id_utensilio'],
          respuesta[i]['node']['nombre'],
          respuesta[i]['node']['descripcion']);
      utensilios.add(utensilio);
      nutensilios.add(respuesta[i]['node']['nombre']);
    }
  }
}

Future<Listado> buscarInformacion(
    List<Receta> recetas,
    List<String> nrecetas,
    List<Dieta> dietas,
    List<String> ndietas,
    List<Ingrediente> ingredientes,
    List<String> ningredientes,
    List<Tipo> tipos,
    List<String> ntipos,
    List<Region> regiones,
    List<String> nregion,
    List<Utensilio> utensilios,
    List<String> nutensilios) async {
  await buscarTipos(tipos, ntipos);
  await buscarRegiones(regiones, nregion);
  await buscarIngredientes(ingredientes, ningredientes);
  await buscarDietas(dietas, ndietas);
  await buscarRecetas(recetas, nrecetas);
  await buscarUtensilios(utensilios, nutensilios);
  Listado nl=Listado(recetas, nrecetas,dietas,ndietas,ingredientes,
      ningredientes,tipos,ntipos,regiones,nregion,utensilios,nutensilios);
  return nl;
}

class Listado {
  Listado(
      @required this.recetas,
      @required this.nrecetas,
      @required this.dietas,
      @required this.ndietas,
      @required this.ingredientes,
      @required this.ningredientes,
      @required this.tipos,
      @required this.ntipos,
      @required this.regiones,
      @required this.nregion,
      @required this.utensilios,
      @required this.nutensilios);
  List<Receta> recetas;
  List<String> nrecetas;
  List<Dieta> dietas;
  List<String> ndietas;
  List<Ingrediente> ingredientes;
  List<String> ningredientes;
  List<Tipo> tipos;
  List<String> ntipos;
  List<Region> regiones;
  List<String> nregion;
  List<Utensilio> utensilios;
  List<String> nutensilios;
}

class construcionBody extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(child: Text('Nombre de la receta: ')),
      Column(
        children: <Widget>[ListadoRecetas()],
      ),
    ]);
  }
}

FutureBuilder nombresRecetas(BuildContext context) {
  return FutureBuilder(
    future: buscarInformacion(recetas, nrecetas,dietas,ndietas,ingredientes,
        ningredientes,tipos,ntipos,regiones,nregion,utensilios,nutensilios),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.hasError.toString()}'));
      }
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
         todosListado= snapshot.data;
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.hasError.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return construcionBody();
        }
      }
    },
  );
}
