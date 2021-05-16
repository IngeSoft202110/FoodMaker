
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
      tieneDieta{objectId nombre}
      TieneIngredientes{edges{node{objectId nombre medida}}}
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
}

