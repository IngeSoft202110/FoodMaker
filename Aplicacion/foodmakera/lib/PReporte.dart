import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Clases/Dieta.dart';
import 'Clases/Ingrediente.dart';
import 'Clases/Receta.dart';
import 'Clases/Region.dart';
import 'Clases/Tipo.dart';
import 'Config/ClienteGraphQL.dart';
import 'Config/StringConsultas.dart';

Listado todosListado=Listado(List<Receta>(),List<String>(),List<Dieta>(),List<String>(),
    List<Ingrediente>(),List<String>(),List<Tipo>(),List<String>(),List<Region>(),List<String>(),
    List<Utensilio>(),List<String>());
String seleccionreceta;
String seleccionTipo;
String seleccionEspecifica;
List<String> info=[];

class PReporte extends StatelessWidget {
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
          body: ConstruccionCuerpo(context)
      );
    }
  }


class construcionBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EstadoBody();
  }

class EstadoBody extends State<construcionBody>{
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(child: Text('Nombre de la receta: ')),
      Column(
        children: <Widget>[ListadoRecetas()],
      ),
      Center(child: Text('Que elemento quiere reportar'),),
      Column(
        children: <Widget>[DropdownButton<String>(
          value: seleccionTipo,
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
              seleccionTipo = newValue;
              cambiarValores();
            }
            );
          },
          items: <String>['Receta','Tipo','Region','Dieta','Ingrediente','Utensilio']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )],
      ),
      Center(child: Text('Nombres Especifico'),),
      Column(
        children: <Widget>[DropdownButton<String>(
            value: seleccionEspecifica,
            icon: const Icon(Icons.arrow_downward),
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
                seleccionEspecifica = newValue;
              });
            },
            items:   info.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
        )],
      ),
      Center(child: Text('Observaciones'),),
      TextField(),
    ]);
  }





}

FutureBuilder ConstruccionCuerpo(BuildContext context) {
  return FutureBuilder(
    future: buscarInformacion(todosListado),
    builder: (context, snapshot) {
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
  );
}


void cambiarValores(){
  if(seleccionreceta.compareTo('Ninguna') == 0){
    if(seleccionTipo.compareTo('Recetas') == 0){
      info=[];
    }else if(seleccionTipo.compareTo('Tipo') == 0){
      info=todosListado.ntipos;
    } else if(seleccionTipo.compareTo('Region') == 0){
      info=todosListado.nregion;
    } else if(seleccionTipo.compareTo('Dieta') == 0){
      info=todosListado.ndietas;
    } else if(seleccionTipo.compareTo('Ingrediente') == 0){
      info=todosListado.ningredientes;
    } else if(seleccionTipo.compareTo('Utensilio') == 0){
      info=todosListado.nutensilios;
    } else {
      info=[];
    }
  }else{
    Receta r=buscarEntreRecetas(seleccionreceta);
    if(r != null){
      if(seleccionTipo.compareTo('Recetas') == 0){
        info=[];
      }else if(seleccionTipo.compareTo('Tipo') == 0){
        info=[r.tipo.nombre];
      } else if(seleccionTipo.compareTo('Region') == 0){
        info=[r.region.nombre];
      } else if(seleccionTipo.compareTo('Dieta') == 0){
        info=[r.dieta.nombre];
      } else if(seleccionTipo.compareTo('Ingrediente') == 0){
        info=nombresIngredientes(r.ingredientes);
      } else if(seleccionTipo.compareTo('Utensilio') == 0){
        info=nombresutensilio(r.utensilios);
      } else {
        info=[];
      }
    }
  }
}

List<String> nombresutensilio(List<Utensilio> utensilios){
  List<String> nutensilios=List<String>();
  utensilios.forEach((element) {
    nutensilios.add(element.nombre);
  });
  return nutensilios;
}

List<String> nombresIngredientes(List<Ingrediente>ingredientes){
  List<String> ningrediente=List<String>();
  ingredientes.forEach((element) { 
    ningrediente.add(element.nombre);
  });
  return ningrediente;
}

Receta buscarEntreRecetas(String Nombre){
  for(int i=0; i < todosListado.recetas.length; i++){
     if(todosListado.recetas[i].Nombre.compareTo(Nombre) == 0){
       return todosListado.recetas[i];
     }
  }
  return null;
}
//------------------------ Se crea el listado con todo los elementos que puede reportar



//-------------------------- Se crea el listado de las recetas que se pueden reportar -----------------
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
  if(nrecetas.indexOf("Ninguna") == -1) nrecetas.add('Ninguna');
  await obtenerRecetas(recetas);
  for(int i=0; i < recetas.length; i++){
    if(nrecetas.indexOf(recetas[i].Nombre) == -1){
      nrecetas.add(recetas[i].Nombre);
    }
  }
}

//Hace el Query en la base de datos
void buscarIngredientes(
    List<Ingrediente> ingredientes, List<String> ningredientes) async {
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
      if(ingredientes.indexOf(ingrediente) == -1){
        ningredientes.add(respuesta[i]['node']['nombre']);
        ingredientes.add(ingrediente);
      }
    }
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
      if(dietas.indexOf(dieta) == -1){
        ndietas.add(respuesta[i]['node']['nombre']);
        dietas.add(dieta);
      }
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
      if(regiones.indexOf(region) == -1){
        regiones.add(region);
        nregion.add(respuesta[i]['node']['nombre']);
      }
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
      if(tipos.indexOf(nd) == -1 ){
        tipos.add(nd);
        ntipos.add(respuesta[i]['node']['nombre']);
      }

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
      if(utensilios.indexOf(utensilio) == -1){
        utensilios.add(utensilio);
        nutensilios.add(respuesta[i]['node']['nombre']);
      }
    }
  }
}

Future<List<Receta>> buscarInformacion(Listado todosListado) async {
  await buscarTipos(todosListado.tipos, todosListado.ntipos);
  await buscarRegiones(todosListado.regiones, todosListado.nregion);
  await buscarIngredientes(todosListado.ingredientes, todosListado.ningredientes);
  await buscarDietas(todosListado.dietas, todosListado.ndietas);
  await buscarRecetas(todosListado.recetas, todosListado.nrecetas);
  await buscarUtensilios(todosListado.utensilios, todosListado.nutensilios);
  return todosListado.recetas;
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




