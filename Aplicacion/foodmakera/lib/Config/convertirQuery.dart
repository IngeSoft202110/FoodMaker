import 'package:foodmakera/Clases/Comentario.dart';
import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Clases/Paso.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Tipo.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Clases/Receta.dart';
import 'ClienteGraphQL.dart';



buscarReceras(List<Receta> recetas) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente.query(
      QueryOptions(documentNode: gql(Consultas().buscartodasRecetas)));
  if (results.hasException) {
      print("ERROR AL TRAER LOS DATOS: ${results.exception}");
  }
  else if(results.isLoading){
    print('Cargando');
  } else if (results.isNotLoading){
    List respuesta=results.data['recetas']['edges'];
    //Se guardan todos los ingredientes de la receta
    for(int i=0; i<respuesta.length; i++){
      //Crear listas de los comentarios
      List<Comentario> comentarios=List<Comentario>();
      //Crea el usuario dueno de la receta
      User usuario;
      //Crea la lista de pasos de la recetas
      List<Paso> pasos= List<Paso>();
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
      List nComentarios=respuesta[i]['node']['tieneComentarios']['edges'];
      for(int j=0; j < nComentarios.length; j++){
        User u=User.incompleto( nComentarios[j]['node']['hizoComentario']['username'],
            nComentarios[j]['node']['hizoComentario']['objectId']);
        print("Descripcion: ${nComentarios[j]['node']['descripcion']}");
        print("ObjectId: ${nComentarios[j]['node']['objectId']}");
        print("Nombre: ${nComentarios[j]['node']['hizoComentario']['username']}");
        print("Like: ${nComentarios[j]['node']['like']['count']}");
        print("Dislike:  ${nComentarios[j]['node']['dislike']['count']}");
        Comentario comentario=Comentario.query(
            nComentarios[j]['node']['descripcion'],nComentarios[j]['node']['objectId'],
            u,
            int.parse(nComentarios[j]['node']['like']['count'].toString()),
            int.parse(nComentarios[j]['node']['dislike']['count'].toString()));
        comentarios.add(comentario);
      }
      List nIngredientes=respuesta[i]['node']['TieneIngredientes']['edges'];
      for(int j=0; j < nIngredientes.length; j++){
        Ingrediente ingrediente=Ingrediente.todo(nIngredientes[j]['node']['ObjectId'], nIngredientes[j]['node']['id_ingrediente'], nIngredientes[j]['node']['nombre'],nIngredientes[j]['node']['medida']);
        ingredientes.add(ingrediente);
      }
      List nUtensilios=respuesta[i]['node']['tieneUtensilios']['edges'];
      for(int j=0; j <nUtensilios.length; j++){
        Utensilio utensilio=Utensilio(nUtensilios[j]['node']['objectId'], nUtensilios[j]['node']['id_utensilio'], nUtensilios[j]['node']['nombre'], nUtensilios[j]['node']['descripcion']);
        utensilios.add(utensilio);
      }
      List nPasos=respuesta[i]['node']['Pasos']['edges'];
      for(int j=0; j < nPasos.length; j++){
        String nombre = nPasos[j]['node']['foto'].toString();
        if(nombre.compareTo('null') != 0 || nombre.length > 4){
          RegExp exp=RegExp(r'http.*');
          final urlexp=exp.firstMatch(nombre.toString());
          String murl=urlexp.group(0);
          String url=murl.substring(0,murl.length-1);
          nombre=url;
        }else{
          nombre= "null";
        }
        Paso paso=Paso(nPasos[j]['node']['objectId'],nPasos[j]['node']['numero'], nPasos[j]['node']['especificacion'], nombre);
        pasos.add(paso);
      }
      //Se setea el usuario dueno de la receta
      usuario=User.incompleto(respuesta[i]['node']['creador']['username'],respuesta[i]['node']['creador']['objectId']);
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
          respuesta[i]['node']['foto']['url'],
          respuesta[i]['node']['vistas'],
          respuesta[i]['node']['tiempo'],
          pasos,
          ingredientes,respuesta[i]['node']['ObjectId'],usuario, comentarios);
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