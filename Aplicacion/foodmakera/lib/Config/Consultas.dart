
import 'package:foodmakera/Pantallas/ListaRecetas.dart';

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

  String buscartodasRecetas = """
  {
  recetas{
    edges{
    node{
      id_receta
      nombre
      descripcion
      tiempo
      vistas
      tiene{edges{node{objectId  descripcion}}}
      foto{url}
      tieneRegion{objectId id_region nombre}
      tieneTipo{objectId id_tipo nombre}
      tieneDieta{objectId id_dieta nombre}
      TieneIngredientes{edges{node{objectId id_ingrediente nombre medida}}}
      pasos
    }
    }
  }
  }
"""
  ;
}
