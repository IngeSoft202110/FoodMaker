import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Tipo.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:foodmakera/Config/Consultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'ClienteGraphQL.dart';



buscarReceras(List<Receta> recetas) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente.query(
      QueryOptions(documentNode: gql(Consultas().buscartodasRecetas)));
  if (results.hasException) {
    print(results.exception);
  }
  else if(results.isLoading){
    print('Cargando');
  } else if (results.data.isNotEmpty){
    Utensilio utensilio= Utensilio(0001, 'vacio');
    Region region;
    Receta nreceta;
    Dieta dieta;
    Tipo tipo;
    List respuesta=results.data['recetas']['edges'];
    for(int i=0; i<respuesta.length; i++){
      region=Region(respuesta[i]['node']['tieneRegion']['id_region'], respuesta[i]['node']['tieneRegion']['nombre']);
      tipo=Tipo(respuesta[i]['node']['tieneTipo']['id_tipo'], respuesta[i]['node']['tieneTipo']['nombre']);
      dieta=Dieta(respuesta[i]['node']['tieneDieta']['id_dieta'], respuesta[i]['node']['tieneDieta']['nombre']);
      nreceta=Receta(dieta, region, tipo, utensilio,
          respuesta[i]['node']['nombre'], respuesta[i]['node']['descripcion'],
          respuesta[i]['node']['foto']['url'], respuesta[i]['node']['vistas'],
          respuesta[i]['node']['tiempo'],respuesta[i]['node']['pasos']);
      recetas.add(nreceta);
    }
  }
}

obtenerRecetas(List<Receta> recetas)async{
  await buscarReceras(recetas);
}