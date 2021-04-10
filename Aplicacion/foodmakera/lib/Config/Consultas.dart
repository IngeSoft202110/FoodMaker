
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

  String buscarRegiones= """
      {
     regiones{
          edges{
            node{
              objectId
              id_tipo
              nombre
            }
          }
     }
    }""";
}
