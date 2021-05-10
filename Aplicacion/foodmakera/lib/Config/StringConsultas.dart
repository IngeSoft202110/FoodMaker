

class Consultas {
  String buscarDietas = """{
     dietas{
        edges{
           node{
              id_dieta
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
              id_tipo
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
            id_region
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
      tieneRegion{objectId id_region nombre}
      tieneTipo{objectId id_tipo nombre}
      tieneDieta{objectId id_dieta nombre}
      TieneIngredientes{edges{node{objectId nombre medida}}}
      creador{objectId username}
      tieneComentarios{edges{node{ objectId descripcion hizoComentario{username objectId} like{count} dislike{count}}}}
    }
    }
  }
  }
""";
}

