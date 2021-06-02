import 'package:foodmakera/Clases/Calificacion.dart';
import 'package:foodmakera/Clases/Comentario.dart';
import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Clases/IngredientexReceta.dart';
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

buscarReceras(List<Receta> recetas, String queryx) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(document: gql(queryx)));
  if (results.hasException) {
    print("ERROR AL TRAER LOS DATOS: ${results.exception}");
  } else if (results.isLoading) {
    print('Cargando');
  } else if (results.isNotLoading) {
    List respuesta = results.data['recetas']['edges'];
    //Se guardan todos los ingredientes de la receta
    for (int i = 0; i < respuesta.length; i++) {
      //Crea las lista de calificaciones
      List<Calificacion> calificaciones=[];
      //Crear listas de los comentarios
      List<Comentario> comentarios = [];
      //Crea el usuario dueno de la receta
      User usuario = User.vacio();
      //Crea la lista de pasos de la recetas
      List<Paso> pasos = [];
      //crea la lista de utensilios de la receta
      List<Utensilio> utensilios = [];
      //Crear la lista de ingredientes de la receta
      List<IngredientexReceta> ingredientes = [];
      //Almacena la region de la receta
      Region region = Region.vacio();
      //Almacena la receta
      Receta nreceta;
      //Almacena la dieta de la receta
      Dieta dieta = Dieta.vacia();
      //Almacena el tipo de receta que es
      Tipo tipo = Tipo.vacio();

      List nCalificaiones=  respuesta[i]['node']['tieneCalificaciones']['edges'];
      for(int k=0; k < nCalificaiones.length; k++){
       User u=User.incompleto(nCalificaiones[k]['usuarioCalifico']['username'], nCalificaiones[k]['usuarioCalifico']['objectId']);
       Calificacion c=Calificacion(nCalificaiones[k]['objectId'],nCalificaiones[k]['puntos'], u);
       calificaciones.add(c);
      }

      List nComentarios = respuesta[i]['node']['tieneComentarios']['edges'];
      for (int j = 0; j < nComentarios.length; j++) {
        User u = User.incompleto(
            nComentarios[j]['node']['hizoComentario']['username'],
            nComentarios[j]['node']['hizoComentario']['objectId']);
        Comentario comentario = Comentario.query(
            nComentarios[j]['node']['descripcion'],
            nComentarios[j]['node']['objectId'],
            u,
            int.parse(nComentarios[j]['node']['like']['count'].toString()),
            int.parse(nComentarios[j]['node']['dislike']['count'].toString()));
        comentarios.add(comentario);
      }
      List nIngredientes = respuesta[i]['node']['tieneIngredientes']['edges'];
      for (int j = 0; j < nIngredientes.length; j++) {
        Ingrediente ingrediente = Ingrediente.todo(
            nIngredientes[j]['node']['tieneIngrediente']['objectId'],
            nIngredientes[j]['node']['tieneIngrediente']['nombre'],
            nIngredientes[j]['node']['tieneIngrediente']['medida']);
        IngredientexReceta irn=IngredientexReceta( ingrediente,nIngredientes[j]['node']['cantidad'],nIngredientes[j]['objectId']);
        ingredientes.add(irn);
      }

      List nUtensilios = respuesta[i]['node']['tieneUtensilios']['edges'];
      for (int j = 0; j < nUtensilios.length; j++) {
        Utensilio utensilio = Utensilio(
            nUtensilios[j]['node']['objectId'],
            nUtensilios[j]['node']['nombre'],
            nUtensilios[j]['node']['descripcion']);
        utensilios.add(utensilio);
      }
      List nPasos = respuesta[i]['node']['Pasos']['edges'];
      for (int j = 0; j < nPasos.length; j++) {
        String nombre = nPasos[j]['node']['foto'].toString();
        if (nombre.compareTo('null') != 0 || nombre.length > 4) {
          RegExp exp = RegExp(r'http.*');
          final urlexp = exp.firstMatch(nombre.toString());
          String murl = urlexp.group(0);
          String url = murl.substring(0, murl.length - 1);
          nombre = url;
        } else {
          nombre = "null";
        }
        Paso paso = Paso(
            nPasos[j]['node']['objectId'],
            nPasos[j]['node']['numero'],
            nPasos[j]['node']['especificacion'],
            nombre);
        pasos.add(paso);
      }
      //Se setea el usuario dueno de la receta
      usuario = User.incompleto(respuesta[i]['node']['creador']['username'],
          respuesta[i]['node']['creador']['objectId']);
      //se seta la region a la receta
      region = Region.Completa(respuesta[i]['node']['tieneRegion']['objectId'],
          respuesta[i]['node']['tieneRegion']['nombre']);
      //se setea el tipo de la receta
      tipo = Tipo.Completa(respuesta[i]['node']['objectId'],
          respuesta[i]['node']['tieneTipo']['nombre']);
      //se setea la dieta de la receta
      dieta = Dieta.Completa(respuesta[i]['node']['tieneDieta']['objectId'],
          respuesta[i]['node']['tieneDieta']['nombre']);
      //se setean los demas de la receta
      nreceta = Receta(
          dieta,
          region,
          tipo,
          utensilios,
          respuesta[i]['node']['nombre'],
          respuesta[i]['node']['descripcion'],
          respuesta[i]['node']['foto']['url'],
          respuesta[i]['node']['vistas'],
          respuesta[i]['node']['tiempo'],
          pasos,
          ingredientes,
          respuesta[i]['node']['objectId'],
          usuario,
          comentarios, calificaciones);
      bool encontre = false;
      //se busca si la receta ya esta en la lista para no agregarla
      for (int i = 0; i < recetas.length; i++) {
        if (recetas[i].Nombre.compareTo(nreceta.Nombre) == 0) {
          encontre = true;
        }
      }
      if (encontre == false) {
         recetas.add(nreceta);
      }
    }
  }
}

obtenerRecetas(List<Receta> recetas, String query) async {
  await buscarReceras(recetas, query);
}

buscarRecerasG(List<Receta> recetas, String queryx) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(document: gql(queryx)));
  if (results.hasException) {
    print("ERROR AL TRAER LOS DATOS: ${results.exception}");
  } else if (results.isLoading) {
    print('Cargando');
  } else if (results.isNotLoading) {
    List respuestaU = results.data['users']['edges'];
    if (respuestaU.length != 0) {
      List respuesta = respuestaU[0]['node']['Guardadas']['edges'];
      //Se guardan todos los ingredientes de la receta
      for (int i = 0; i < respuesta.length; i++) {
        //Crea las lista de calificaciones
        List<Calificacion> calificaciones = [];
        //Crear listas de los comentarios
        List<Comentario> comentarios = [];
        //Crea el usuario dueno de la receta
        User usuario = User.vacio();
        //Crea la lista de pasos de la recetas
        List<Paso> pasos = [];
        //crea la lista de utensilios de la receta
        List<Utensilio> utensilios = [];
        //Crear la lista de ingredientes de la receta
        List<IngredientexReceta> ingredientes = [];
        //Almacena la region de la receta
        Region region = Region.vacio();
        //Almacena la receta
        Receta nreceta;
        //Almacena la dieta de la receta
        Dieta dieta = Dieta.vacia();
        //Almacena el tipo de receta que es
        Tipo tipo = Tipo.vacio();

        List nCalificaiones = respuesta[i]['node']['tieneCalificaciones']['edges'];
        for (int k = 0; k < nCalificaiones.length; k++) {
          User u = User.incompleto(
              nCalificaiones[k]['usuarioCalifico']['username'],
              nCalificaiones[k]['usuarioCalifico']['objectId']);
          Calificacion c = Calificacion(
              nCalificaiones[k]['objectId'], nCalificaiones[k]['puntos'], u);
          calificaciones.add(c);
        }

        List nComentarios = respuesta[i]['node']['tieneComentarios']['edges'];
        for (int j = 0; j < nComentarios.length; j++) {
          User u = User.incompleto(
              nComentarios[j]['node']['hizoComentario']['username'],
              nComentarios[j]['node']['hizoComentario']['objectId']);
          Comentario comentario = Comentario.query(
              nComentarios[j]['node']['descripcion'],
              nComentarios[j]['node']['objectId'],
              u,
              int.parse(nComentarios[j]['node']['like']['count'].toString()),
              int.parse(
                  nComentarios[j]['node']['dislike']['count'].toString()));
          comentarios.add(comentario);
        }
        List nIngredientes = respuesta[i]['node']['tieneIngredientes']['edges'];
        for (int j = 0; j < nIngredientes.length; j++) {
          Ingrediente ingrediente = Ingrediente.todo(
              nIngredientes[j]['node']['tieneIngrediente']['objectId'],
              nIngredientes[j]['node']['tieneIngrediente']['nombre'],
              nIngredientes[j]['node']['tieneIngrediente']['medida']);
          IngredientexReceta irn = IngredientexReceta(
              ingrediente, nIngredientes[j]['node']['cantidad'],
              nIngredientes[j]['objectId']);
          ingredientes.add(irn);
        }

        List nUtensilios = respuesta[i]['node']['tieneUtensilios']['edges'];
        for (int j = 0; j < nUtensilios.length; j++) {
          Utensilio utensilio = Utensilio(
              nUtensilios[j]['node']['objectId'],
              nUtensilios[j]['node']['nombre'],
              nUtensilios[j]['node']['descripcion']);
          utensilios.add(utensilio);
        }
        List nPasos = respuesta[i]['node']['Pasos']['edges'];
        for (int j = 0; j < nPasos.length; j++) {
          String nombre = nPasos[j]['node']['foto'].toString();
          if (nombre.compareTo('null') != 0 || nombre.length > 4) {
            RegExp exp = RegExp(r'http.*');
            final urlexp = exp.firstMatch(nombre.toString());
            String murl = urlexp.group(0);
            String url = murl.substring(0, murl.length - 1);
            nombre = url;
          } else {
            nombre = "null";
          }
          Paso paso = Paso(
              nPasos[j]['node']['objectId'],
              nPasos[j]['node']['numero'],
              nPasos[j]['node']['especificacion'],
              nombre);
          pasos.add(paso);
        }
        //Se setea el usuario dueno de la receta
        usuario = User.incompleto(respuesta[i]['node']['creador']['username'],
            respuesta[i]['node']['creador']['objectId']);
        //se seta la region a la receta
        region =
            Region.Completa(respuesta[i]['node']['tieneRegion']['objectId'],
                respuesta[i]['node']['tieneRegion']['nombre']);
        //se setea el tipo de la receta
        tipo = Tipo.Completa(respuesta[i]['node']['objectId'],
            respuesta[i]['node']['tieneTipo']['nombre']);
        //se setea la dieta de la receta
        dieta = Dieta.Completa(respuesta[i]['node']['tieneDieta']['objectId'],
            respuesta[i]['node']['tieneDieta']['nombre']);
        //se setean los demas de la receta
        nreceta = Receta(
            dieta,
            region,
            tipo,
            utensilios,
            respuesta[i]['node']['nombre'],
            respuesta[i]['node']['descripcion'],
            respuesta[i]['node']['foto']['url'],
            respuesta[i]['node']['vistas'],
            respuesta[i]['node']['tiempo'],
            pasos,
            ingredientes,
            respuesta[i]['node']['objectId'],
            usuario,
            comentarios,
            calificaciones);
        bool encontre = false;
        //se busca si la receta ya esta en la lista para no agregarla
        for (int i = 0; i < recetas.length; i++) {
          if (recetas[i].Nombre.compareTo(nreceta.Nombre) == 0) {
            encontre = true;
          }
        }
        if (encontre == false) {
          recetas.add(nreceta);
        }
      }
    }
  }else{
    recetas=[];
  }
}

obtenerRecetasG(List<Receta> recetas, String query) async {
  await buscarReceras(recetas, query);
}

buscarReceta(List<int> visitas, String objectId) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(document: gql(recetaParaSumarVisita(objectId))));
  if (results.hasException) {
    print(results.exception);
  } else if (results.isNotLoading) {
    List recetas = results.data['recetas']['edges'];
    if (recetas.length != 0) {
      visitas.add(recetas[0]['node']['vistas']);
    } else {
      visitas.add(-1);
    }
  }
}

obtenerReceta(List<int> visitas, String objectId) async {
  await buscarReceta(visitas, objectId);
}

buscarRecerasPorID(List<Receta> recetas, String objectId) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(document: gql(buscarRecetaComplet(objectId))));
  if (results.hasException) {
    print("ERROR AL TRAER LOS DATOS: ${results.exception}");
  } else if (results.isLoading) {
    print('Cargando');
  } else if (results.isNotLoading) {
    List respuesta = results.data['recetas']['edges'];
    //Se guardan todos los ingredientes de la receta
    //Crea la lista de calificaciones
    List<Calificacion> calificaciones=[];
    //Crear listas de los comentarios
    List<Comentario> comentarios = [];
    //Crea el usuario dueno de la receta
    User usuario = User.vacio();
    //Crea la lista de pasos de la recetas
    List<Paso> pasos = [];
    //crea la lista de utensilios de la receta
    List<Utensilio> utensilios = [];
    //Crear la lista de ingredientes de la receta
    List<IngredientexReceta> ingredientes = [];
    //Almacena la region de la receta
    Region region = Region.vacio();
    //Almacena la receta
    Receta nreceta;
    //Almacena la dieta de la receta
    Dieta dieta = Dieta.vacia();
    //Almacena el tipo de receta que es
    Tipo tipo = Tipo.vacio();
    if (respuesta != null) {

      List nCalificaiones=  respuesta[0]['node']['tieneCalificaciones']['edges'];
      for(int k=0; k < nCalificaiones.length; k++){
        User u=User.incompleto(nCalificaiones[k]['usuarioCalifico']['username'], nCalificaiones[k]['usuarioCalifico']['objectId']);
        Calificacion c=Calificacion(nCalificaiones[k]['objectId'],nCalificaiones[k]['puntos'], u);
        calificaciones.add(c);
      }

      List nComentarios = respuesta[0]['node']['tieneComentarios']['edges'];
      for (int j = 0; j < nComentarios.length; j++) {
        User u = User.incompleto(
            nComentarios[j]['node']['hizoComentario']['username'],
            nComentarios[j]['node']['hizoComentario']['objectId']);
        Comentario comentario = Comentario.query(
            nComentarios[j]['node']['descripcion'],
            nComentarios[j]['node']['objectId'],
            u,
            int.parse(nComentarios[j]['node']['like']['count'].toString()),
            int.parse(nComentarios[j]['node']['dislike']['count'].toString()));
        comentarios.add(comentario);
      }
      List nIngredientes = respuesta[0]['node']['tieneIngredientes']['edges'];
      for (int j = 0; j < nIngredientes.length; j++) {

        Ingrediente ingrediente = Ingrediente.todo(
            nIngredientes[j]['node']['tieneIngrediente']['objectId'],
            nIngredientes[j]['node']['tieneIngrediente']['nombre'],
            nIngredientes[j]['node']['tieneIngrediente']['medida']);
        IngredientexReceta irn=IngredientexReceta( ingrediente,nIngredientes[j]['node']['cantidad'],nIngredientes[j]['objectId']);
        ingredientes.add(irn);
      }
      List nUtensilios = respuesta[0]['node']['tieneUtensilios']['edges'];
      for (int j = 0; j < nUtensilios.length; j++) {
        Utensilio utensilio = Utensilio(
            nUtensilios[j]['node']['objectId'],
            nUtensilios[j]['node']['nombre'],
            nUtensilios[j]['node']['descripcion']);
        utensilios.add(utensilio);
      }
      List nPasos = respuesta[0]['node']['Pasos']['edges'];
      for (int j = 0; j < nPasos.length; j++) {
        String nombre = nPasos[j]['node']['foto'].toString();
        if (nombre.compareTo('null') != 0 || nombre.length > 4) {
          RegExp exp = RegExp(r'http.*');
          final urlexp = exp.firstMatch(nombre.toString());
          String murl = urlexp.group(0);
          String url = murl.substring(0, murl.length - 1);
          nombre = url;
        } else {
          nombre = 'null';
        }
        Paso paso = Paso(
            nPasos[j]['node']['objectId'],
            nPasos[j]['node']['numero'],
            nPasos[j]['node']['especificacion'],
            nombre);
        pasos.add(paso);
      }
      //Se setea el usuario dueno de la receta
      usuario = User.incompleto(respuesta[0]['node']['creador']['username'],
          respuesta[0]['node']['creador']['objectId']);
      //se seta la region a la receta
      region = Region.Completa(respuesta[0]['node']['tieneRegion']['objectId'],
          respuesta[0]['node']['tieneRegion']['nombre']);
      //se setea el tipo de la receta
      tipo = Tipo.Completa(respuesta[0]['node']['objectId'],
          respuesta[0]['node']['tieneTipo']['nombre']);
      //se setea la dieta de la receta
      dieta = Dieta.Completa(respuesta[0]['node']['tieneDieta']['objectId'],
          respuesta[0]['node']['tieneDieta']['nombre']);
      //se setean los demas de la receta
      nreceta = Receta(
          dieta,
          region,
          tipo,
          utensilios,
          respuesta[0]['node']['nombre'],
          respuesta[0]['node']['descripcion'],
          respuesta[0]['node']['foto']['url'],
          respuesta[0]['node']['vistas'],
          respuesta[0]['node']['tiempo'],
          pasos,
          ingredientes,
          respuesta[0]['node']['objectId'],
          usuario,
          comentarios,calificaciones);
      recetas.add(nreceta);
    } else {
      recetas = [];
    }
  }
}

obtenerRecetasPorID(List<Receta> recetas, String objectId) async {
  await buscarRecerasPorID(recetas, objectId);
}

buscarComentariosReceta(List<Comentario> comentarios, String objectId) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(document: gql(buscarRecetaComplet(objectId))));
  if (results.hasException) {
    print("ERROR AL TRAER LOS DATOS: ${results.exception}");
  } else if (results.isLoading) {
    print('Cargando');
  } else if (results.isNotLoading) {
    List respuesta = results.data['recetas']['edges'];
    if (respuesta != null) {
      List nComentarios = respuesta[0]['node']['tieneComentarios']['edges'];
      for (int j = 0; j < nComentarios.length; j++) {
        User u = User.incompleto(
            nComentarios[j]['node']['hizoComentario']['username'],
            nComentarios[j]['node']['hizoComentario']['objectId']);
        Comentario comentario = Comentario.query(
            nComentarios[j]['node']['descripcion'],
            nComentarios[j]['node']['objectId'],
            u,
            int.parse(nComentarios[j]['node']['like']['count'].toString()),
            int.parse(nComentarios[j]['node']['dislike']['count'].toString()));
        comentarios.add(comentario);
      }
    }
  }
}

obtenerComentariosReceta(List<Comentario> comentarios, String objectId) async {
  await buscarComentariosReceta(comentarios, objectId);
}
