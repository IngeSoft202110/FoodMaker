import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Tipo.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:foodmakera/Config/Consultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Clases/Receta.dart';
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
  } else if (results.isNotLoading){
    List respuesta=results.data['recetas']['edges'];
    //Se guardan todos los ingredientes de la receta
    for(int i=0; i<respuesta.length; i++){
      //crea la lista de utensilios de la receta
      List<Utensilio> utensilios=List<Utensilio>();
      //Crear la lista de ingredientes de la receta
      List<Ingrediente> ingredientes=List<Ingrediente>();
      //Almacena la region de la receta
      Region region;
      //Almacena la receta
      Receta nreceta;
      //Almacena la dieta de la receta
      Dieta dieta;
      //Almacena el tipo de receta que es
      Tipo tipo;
      List nIngredientes=respuesta[i]['node']['TieneIngredientes']['edges'];
      for(int j=0; j < nIngredientes.length; j++){
        Ingrediente ingrediente=Ingrediente.todo(nIngredientes[j]['node']['ObjectId'], nIngredientes[j]['node']['id_ingrediente'], nIngredientes[j]['node']['id_nombre'],nIngredientes[j]['node']['medida']);
        ingredientes.add(ingrediente);
      }
      List nUtensilios=respuesta[i]['node']['tieneUtensilios']['edges'];
      for(int i=0; i <nUtensilios.length; i++){
        Utensilio utensilio=Utensilio(nUtensilios[i]['node']['objectId'], nUtensilios[i]['node']['id_utensilio'], nUtensilios[i]['node']['nombre'], nUtensilios[i]['node']['descripcion']);
        utensilios.add(utensilio);
      }
      //se seta la region a la receta
      region=Region(respuesta[i]['node']['tieneRegion']['id_region'], respuesta[i]['node']['tieneRegion']['nombre']);
      //se setea el tipo de la receta
      tipo=Tipo(respuesta[i]['node']['tieneTipo']['id_tipo'], respuesta[i]['node']['tieneTipo']['nombre']);
      //se setea la dieta de la receta
      dieta=Dieta(respuesta[i]['node']['tieneDieta']['id_dieta'], respuesta[i]['node']['tieneDieta']['nombre']);
      //se setean los demas de la receta
      nreceta=Receta(dieta, region, tipo, utensilios,
          respuesta[i]['node']['nombre'],
          respuesta[i]['node']['descripcion'],
          //respuesta[i]['node']['foto']['url'],
          'https://cdn.kiwilimon.com/recetaimagen/36838/th5-320x320-46031.jpg',
          respuesta[i]['node']['vistas'],
          respuesta[i]['node']['tiempo'],
          respuesta[i]['node']['pasos']);
      bool encontre=false;
      //se busca si la receta ya esta en la lista para no agregarla
      for(int i=0; i < recetas.length; i++){
        if(recetas[i].Nombre.compareTo(nreceta.Nombre) == 0){
          encontre=true;
        }
      }
      if(encontre == false){
        recetas.add(nreceta);
      }
    }
  }
}


obtenerRecetas(List<Receta> recetas)async{
  await buscarReceras(recetas);
}