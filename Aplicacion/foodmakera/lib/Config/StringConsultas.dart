
class Consultas {
  String buscarDietas = """{
     dietas{
        edges{
           node{
              objectId
              nombre
          }
        }
     }
    }""";


  String buscarIngredientes = """
      {
     ingredientes{
          edges{
            node{
              objectId
              nombre
              medida
            }
          }
     }
    }""";

  String buscarTipos = """
      {
     tipos{
          edges{
            node{
              objectId
              nombre
            }
          }
     }
    }""";

  String buscarRegiones = """
  {
     regions{
        edges{
          node{
            objectId
            nombre
          }
        }
     }
  }""";

  String buscarUtensilios = """
  {
     utensilios{
        edges{
          node{
            objectId
            nombre
            descripcion
          }
        }
     }
  }""";

  String buscartodasRecetas = """
{
  recetas{
    edges{
    node{
      objectId
      nombre
      descripcion
      tiempo
      vistas
      foto{url}
      Pasos(order:numero_ASC){edges{node{objectId numero especificacion foto{url} }}}
      tieneUtensilios{edges{node{objectId nombre descripcion}}}
      tieneRegion{objectId nombre}
      tieneTipo{objectId nombre}
      tieneIngredientes{ edges {node { objectId  cantidad  tieneIngrediente{objectId  nombre medida}}}}
      tieneDieta{objectId nombre}
      creador{objectId username}
      tieneComentarios{edges{node{ objectId descripcion hizoComentario{username objectId} like{count} dislike{count}}}}
    }
    }
  }
  }
""";

String buscarUsuario = """
 query buscarUsuario{
     users{
          edges{
            node{
              username
              objectId
              Descripcion
            
            }
          }
     }
 }


""";

  String usuarios = """
{
  users{
    edges{
      node{
        objectId
        username
      }
    }
  }
}
""";
}



String devolverStringUsuario(String nombre){
  return """
{
users(where: {username: {equalTo: "${nombre}"}}){
    edges{
      node{
        email
        objectId
        username
        Seguidos{count}
        Descripcion
        pais
        Guardadas{edges{node{objectId}}}
      }
    }
  }
}
""";
}

String recetaParaSumarVisita(String objectId){
  return """
  {
    recetas(where: {objectId: {equalTo: "${objectId}"}}){
      edges{
        node{
          vistas
        }
      }
    }
  }""";
}

String buscarRecetaComplet(String objectId){
  return """
  {
  recetas(where: {objectId: {equalTo: "${objectId}"}}){
    edges{
    node{
      objectId
      nombre
      descripcion
      tiempo
      vistas
      foto{url}
      Pasos(order:numero_ASC){edges{node{objectId numero especificacion foto{url} }}}
      tieneUtensilios{edges{node{objectId nombre descripcion}}}
      tieneRegion{objectId nombre}
      tieneTipo{objectId nombre}
      tieneDieta{objectId nombre}
      tieneIngredientes{ edges {node { objectId  cantidad  tieneIngrediente{objectId  nombre medida}}}}
      creador{objectId username}
      tieneComentarios{edges{node{ objectId descripcion hizoComentario{username objectId} like{count} dislike{count}}}}
    }
    }
  }
  }
""";
}

String buscarComentarioReceta(String objectId) {
  return """
  {
    recetas(where: {objectId: {equalTo: "${objectId}"}}){
      edges{
        node{
          objectId
          tieneComentarios{edges{node{ objectId descripcion hizoComentario{username objectId} like{count} dislike{count}}}}
        }
      }
    }
  }
}
""";
}
