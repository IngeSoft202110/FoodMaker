
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

}