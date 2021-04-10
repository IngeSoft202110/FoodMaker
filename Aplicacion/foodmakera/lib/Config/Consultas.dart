
class Consultas {
  String query = """query obtenerDietas{
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


  String buscarIngredientes= """
      {
     ingredientes{
          edges{
            node{
              objectId
              id_ingrediente
              nombre
              medida
            }
          }
     }
    }""";

  String buscarTipos= """
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
            id_utensilio
            nombre
          }
        }
     }
  }""";
}
