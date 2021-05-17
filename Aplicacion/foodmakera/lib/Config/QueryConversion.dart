
import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Tipo.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Clases/User.dart';
import '../Clases/User.dart';
import 'ClienteGraphQL.dart';
import 'StringConsultas.dart';

//Busca todos los objetos de la clase tipo y los almacena en una lista de tipos
void buscarDBTipos(List<Tipo> tipos) async {
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
          respuesta[i]['node']['nombre']);
      if (tipos.indexOf(nd) == -1) {
        tipos.add(nd);
      }
    }
  }
}

obtenerTipo(List<Tipo> tipos) async{
  await buscarDBTipos(tipos);
}

void buscarBDRegiones(List<Region> regiones) async{
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarRegiones)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['regions']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Region region = Region.Completa(respuesta[i]['node']['ObjectId'], respuesta[i]['node']['nombre']);
      if (regiones.indexOf(region) == -1) {
        regiones.add(region);
      }
    }
  }
}

obtenerRegiones(List<Region> regiones) async{
  await buscarBDRegiones(regiones);
}

void buscarBDUtensilios(List<Utensilio> utensilios) async{
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
          respuesta[i]['node']['nombre'],
          respuesta[i]['node']['descripcion']);
      if (utensilios.indexOf(utensilio) == -1) {
        utensilios.add(utensilio);
      }
    }
  }
}

obtenerUtensilios(List<Utensilio> utensilios) async{
  await buscarBDUtensilios(utensilios);
}

void buscarDBDietas(List<Dieta> dietas) async{
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results =
      await cliente.query(QueryOptions(documentNode: gql(Consultas().buscarDietas)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    List respuesta = results.data['dietas']['edges'];
    for (int i = 0; i < respuesta.length; i++) {
      Dieta dieta = Dieta.Completa(respuesta[i]['node']['ObjectId'],
          respuesta[i]['node']['nombre']);
      if (dietas.indexOf(dieta) == -1) {
        dietas.add(dieta);
      }
    }
  }
}

obtenerDietas(List<Dieta> dietas) async{
  await buscarDBDietas(dietas);
}

void buscarDBIngredientes(List<Ingrediente> ingredientes) async{
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
      Ingrediente ingrediente = Ingrediente.todo(
          respuesta[i]['node']['objectId'],
          respuesta[i]['node']['nombre'],
          respuesta[i]['node']['medida']);
      if (ingredientes.indexOf(ingrediente) == -1 && ingredientes.length < respuesta.length) {
        ingredientes.add(ingrediente);
      }
    }
  }
}

obtenerIngredientes(List<Ingrediente> ingredientes) async{
  await buscarDBIngredientes(ingredientes);
}
void buscarDBUsuario(String nombreusuario, List<User> usuariox) async{
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente.query(
    QueryOptions(documentNode: gql(devolverStringUsuario(nombreusuario)))
  );
  if(results.hasException){
    print(results.exception);
  }
  else if(results.data.isNotEmpty){
    List usuarios = results.data['users']['edges'];
    User nusuario = User.completo(usuarios[0]['node']['username'], usuarios[0]['node']['Descripcion'], usuarios[0]['node']['email'], usuarios[0]['node']['objectId'], usuarios[0]['node']['Seguidos']['count'], usuarios[0]['node']['pais']);
    /*print("Descripcion: ${usuario.descripcion}");
    print("Corre: ${usuario.correo}");
    print("Nombre: ${usuario.username}");
    print("Numero: ${usuario.seguidores}");
    print("Object: ${usuario.objectId}");*/
    usuariox.add(nusuario);
  }

}
obtenerUsuario(String nombreusuario, List<User> usuariox) async{
  await buscarDBUsuario(nombreusuario,usuariox);
}