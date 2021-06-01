import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/IngredientexReceta.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'Clases/Dieta.dart';
import 'Clases/Ingrediente.dart';
import 'Clases/Receta.dart';
import 'Clases/Region.dart';
import 'Clases/Reporte.dart';
import 'Clases/Tipo.dart';

TextStyle titulos = TextStyle(fontSize: 16);
TextStyle estilomenus = TextStyle(fontSize: 14, color: Colors.black);
Listado todosListado = Listado([], [], [], [], [], [], [], [], [], [], [], []);
String seleccionreceta;
String auxSeleccionEspecifica;
String seleccionTipo;
String seleccionEspecifica;
List<String> info = [];
TextEditingController controlador = TextEditingController();
List<String> sinReceta = [
  'Tipo',
  'Region',
  'Dieta',
  'Ingrediente',
  'Utensilio'
];
List<String> conReceta = [
  'Receta',
  'Tipo',
  'Region',
  'Dieta',
  'Ingrediente',
  'Utensilio'
];
List<String> nombres = [];

void conectarse() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Se conecta con back 4 app
  final keyApplicationId = 'nM1RCyRonJmydDakhBrLPQ5KMVusct3ngqG0Hi8B';
  final keyClientKey = 'nT22X3l7fDRJ1oI1UcElOCeaKnRNOSoTv44IwvFh';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
}

class PReporte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Crear Reporte',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
            margin: EdgeInsets.all(20), child: ConstruccionCuerpo(context)));
  }
}

class construcionBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoBody();
}

class EstadoBody extends State<construcionBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(
          child: Text(
        'Nombre de la receta: ',
        style: titulos,
      )),
      //Muestra la informacion principal
      Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            hint: Text('Seleccione una Receta'),
            value: seleccionreceta,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: estilomenus,
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionreceta = newValue;
                if (seleccionreceta.compareTo('Ninguna') == 0) {
                  nombres = sinReceta;
                } else {
                  nombres = conReceta;
                }
                seleccionTipo = null;
                seleccionEspecifica = null;
                info = [];
              });
            },
            items: todosListado.nrecetas
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Center(
        child: Text(
          '¿Qué elemento quiere reportar?',
          style: titulos,
        ),
      ),
      //Lista con los elementos que puede reportar
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el tipo de elemento a reportar'),
            value: seleccionTipo,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: estilomenus,
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionTipo = newValue;
                cambiarValores();
                seleccionEspecifica = null;
              });
            },
            items: nombres.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Center(
        child: Text(
          'Nombres Específico',
          style: titulos,
        ),
      ),
      Column(
        children: <Widget>[
          DropdownButton<String>(
              hint: Text(
                'Seleccione el elemento a reportar',
              ),
              value: seleccionEspecifica,
              icon: const Icon(Icons.arrow_drop_down_circle_outlined),
              iconSize: 24,
              elevation: 16,
              style: estilomenus,
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              isExpanded: true,
              onChanged: (String newValue) {
                setState(() {
                  seleccionEspecifica = newValue;
                  auxSeleccionEspecifica = newValue;
                });
              },
              items: info.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList())
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Center(
        child: Text(
          'Escriba el motivo de su reporte',
          style: titulos,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
          width: MediaQuery.of(context).size.width - 30,
          height: 80,
          child: TextField(
            maxLines: null,
            controller: controlador,
            decoration: InputDecoration(border: OutlineInputBorder()),
          )),
      SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () {
            hacerReporte();
          },
          child: Text('Reportar'))
    ]);
  }

  hacerReporte() {
    Reporte reporte = Reporte.vacio();
    // Comprobar si selecciona una receta o ninguna pero no deja vacio el campo
    if (seleccionreceta != null) {
      // Se comprueba si no eligio una receta para llenar el reporte
      if (seleccionreceta.compareTo('Ninguna') == 0) {
        if (seleccionTipo != null) {
          if (seleccionEspecifica != null) {
            reporte.nombreReceta = null;
            reporte.tipo = seleccionTipo;
            reporte.estado = false;
            reporte.idUsuario = null;
            // -------------Se busca que tipo de reporte va hacer y se guarda su id
            if (seleccionTipo.compareTo('Tipo') == 0) {
              for (int i = 0; i < todosListado.tipos.length; i++) {
                if (todosListado.tipos[i].nombre
                        .compareTo(auxSeleccionEspecifica) ==
                    0) {
                  reporte.nombre = todosListado.tipos[i].objectId;
                }
              }
            } else if (seleccionTipo.compareTo('Region') == 0) {
              for (int i = 0; i < todosListado.regiones.length; i++) {
                if (todosListado.regiones[i].nombre
                        .compareTo(auxSeleccionEspecifica) ==
                    0) {
                  reporte.nombre = todosListado.regiones[i].objectId;
                }
              }
            } else if (seleccionTipo.compareTo('Dieta') == 0) {
              for (int i = 0; i < todosListado.dietas.length; i++) {
                if (todosListado.dietas[i].nombre
                        .compareTo(auxSeleccionEspecifica) ==
                    0) {
                  reporte.nombre = todosListado.dietas[i].objectId;
                }
              }
            } else if (seleccionTipo.compareTo('Ingrediente') == 0) {
              for (int i = 0; i < todosListado.ingredientes.length; i++) {
                if (todosListado.ingredientes[i].nombre
                        .compareTo(auxSeleccionEspecifica) ==
                    0) {
                  reporte.nombre = todosListado.ingredientes[i].objectId;
                }
              }
            } else if (seleccionTipo.compareTo('Utensilio') == 0) {
              for (int i = 0; i < todosListado.utensilios.length; i++) {
                if (todosListado.utensilios[i].nombre
                        .compareTo(auxSeleccionEspecifica) ==
                    0) {
                  reporte.nombre = todosListado.utensilios[i].objectId;
                }
              }
              //----------------------------------------------------
              //se crea el reporte en la base de datos
            }
            crearBase(reporte);
          } else {
            AlertaError(context,
                "Debe seleccionar un elemento especifico para reportar");
          }
        } else {
          AlertaError(
              context, "Debe seleccionar un tipo de elemento a reportar");
        }
        //--------------------------------------
      }
      // si se selecciono una receta se llena la informacion del reporte con esta informacion
      else {
        Receta recesta;
        for (int i = 0; i < todosListado.recetas.length; i++) {
          if (todosListado.recetas[i].Nombre.compareTo(seleccionreceta) == 0) {
            recesta = todosListado.recetas[i];
          }
        }
        //Se comprueba si la receta que selecciono existe
        if (recesta != null) {
          reporte.nombreReceta = seleccionreceta;
          reporte.tipo = seleccionTipo;
          reporte.estado = false;
          reporte.idUsuario = null;
          if (seleccionTipo.compareTo('Tipo') == 0) {
            reporte.nombre = recesta.tipo.objectId;
          } else if (seleccionTipo.compareTo('Region') == 0) {
            reporte.nombre = recesta.region.objectId;
          } else if (seleccionTipo.compareTo('Dieta') == 0) {
            reporte.nombre = recesta.dieta.objectId;
          } else if (seleccionTipo.compareTo('Ingrediente') == 0) {
            for (int i = 0; i < recesta.ingredientes.length; i++) {
              if (recesta.ingredientes[i].ingriente.nombre
                      .compareTo(auxSeleccionEspecifica) ==
                  0) {
                reporte.nombre = recesta.ingredientes[i].objectId;
              }
            }
          } else if (seleccionTipo.compareTo('Utensilio') == 0) {
            for (int i = 0; i < recesta.utensilios.length; i++) {
              if (recesta.utensilios[i].nombre
                      .compareTo(auxSeleccionEspecifica) ==
                  0) {
                reporte.nombre = recesta.utensilios[i].objectId;
              }
            }
          }
          crearBase(reporte);
        } else {
          AlertaError(context, "Hubo un problema con la receta");
        }
      }
    } else {
      AlertaError(context, "Debe seleccionar una receta, o la opción Ninguna");
    }
  }

  AlertaError(BuildContext context, String texto) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Mensaje de Alerta"),
              content: new Text(texto),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cerrar'))
              ],
            ));
  }

  void crearBase(Reporte reporte) async {
    print("object: ${reporte.nombre}");
    final crearReport = ParseObject('Reporte')
      ..set('nombreReceta', reporte.nombreReceta)
      ..set('nombre', reporte.nombre)
      ..set('estado', reporte.estado)
      ..set('idUsuario', reporte.idUsuario)
      ..set('tipo', reporte.tipo)
      ..set('descripcion', controlador.text);
    var respuesta = await crearReport.save();
    if (respuesta.success) {
      AlertaError(context, "Su reporte se creo con normalidad");
      controlador.clear();
    }
    setState(() {
      seleccionreceta='Ninguna';
      seleccionTipo = null;
      seleccionEspecifica = null;
      info = [];
    });
  }
}

FutureBuilder ConstruccionCuerpo(BuildContext context) {
  return FutureBuilder(
      future: buscarInformacion(todosListado),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          return construcionBody();
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return construcionBody();
        }
      });
}

void cambiarValores() {
  if (seleccionreceta.compareTo('Ninguna') == 0) {
    if (seleccionTipo.compareTo('Tipo') == 0) {
      info = todosListado.ntipos;
    } else if (seleccionTipo.compareTo('Region') == 0) {
      info = todosListado.nregion;
    } else if (seleccionTipo.compareTo('Dieta') == 0) {
      info = todosListado.ndietas;
    } else if (seleccionTipo.compareTo('Ingrediente') == 0) {
      info = todosListado.ningredientes;
    } else if (seleccionTipo.compareTo('Utensilio') == 0) {
      info = todosListado.nutensilios;
    } else {
      info = [];
    }
  } else {
    Receta r = buscarEntreRecetas(seleccionreceta);
    if (r != null) {
      if (seleccionTipo.compareTo('Recetas') == 0) {
        info = [];
      } else if (seleccionTipo.compareTo('Tipo') == 0) {
        info = [r.tipo.nombre];
      } else if (seleccionTipo.compareTo('Region') == 0) {
        info = [r.region.nombre];
      } else if (seleccionTipo.compareTo('Dieta') == 0) {
        info = [r.dieta.nombre];
      } else if (seleccionTipo.compareTo('Ingrediente') == 0) {
        List<String> nombres = nombresIngredientes(r.ingredientes);
        info = nombres;
      } else if (seleccionTipo.compareTo('Utensilio') == 0) {
        info = nombresutensilio(r.utensilios);
      } else {
        info = [];
      }
    }
  }
}

List<String> nombresutensilio(List<Utensilio> utensilios) {
  List<String> nutensilios = [];
  utensilios.forEach((element) {
    nutensilios.add(element.nombre);
  });
  return nutensilios;
}

List<String> nombresIngredientes(List<IngredientexReceta> ingredientes) {
  List<String> ningrediente = [];
  ingredientes.forEach((element) {
    ningrediente.add(element.ingriente.nombre);
  });
  return ningrediente;
}

Receta buscarEntreRecetas(String Nombre) {
  for (int i = 0; i < todosListado.recetas.length; i++) {
    if (todosListado.recetas[i].Nombre.compareTo(Nombre) == 0) {
      return todosListado.recetas[i];
    }
  }
  return null;
}

void buscarRecetas(List<Receta> recetas, List<String> nrecetas) async {
  if (nrecetas.indexOf("Ninguna") == -1) nrecetas.add('Ninguna');
  await obtenerRecetas(recetas, Consultas().buscartodasRecetas);
  for (int i = 0; i < recetas.length; i++) {
    if (nrecetas.indexOf(recetas[i].Nombre) == -1) {
      nrecetas.add(recetas[i].Nombre);
    }
  }
}

//Hace el Query en la base de datos
void buscarIngredientes(
    List<Ingrediente> ingredientes, List<String> ningredientes) async {
  await obtenerIngredientes(ingredientes);
  for (int i = 0; i < ingredientes.length; i++) {
    ningredientes.add(ingredientes[i].nombre);
  }
}

void buscarDietas(List<Dieta> dietas, List<String> ndietas) async {
  await obtenerDietas(dietas);
  for (int i = 0; i < dietas.length; i++) {
    ndietas.add(dietas[i].nombre);
  }
}

void buscarRegiones(List<Region> regiones, List<String> nregion) async {
  await obtenerRegiones(regiones);
  for (int i = 0; i < regiones.length; i++) {
    nregion.add(regiones[i].nombre);
  }
}

void buscarTipos(List<Tipo> tipos, List<String> ntipos) async {
  await obtenerTipo(tipos);
  for (int i = 0; i < tipos.length; i++) {
    ntipos.add(tipos[i].nombre);
  }
}

void buscarUtensilios(
    List<Utensilio> utensilios, List<String> nutensilios) async {
  await obtenerUtensilios(utensilios);
  for (int i = 0; i < utensilios.length; i++) {
    nutensilios.add(utensilios[i].nombre);
  }
}

Future<List<Receta>> buscarInformacion(Listado todosListado) async {
  await buscarTipos(todosListado.tipos, todosListado.ntipos);
  await buscarRegiones(todosListado.regiones, todosListado.nregion);
  await buscarIngredientes(
      todosListado.ingredientes, todosListado.ningredientes);
  await buscarDietas(todosListado.dietas, todosListado.ndietas);
  await buscarRecetas(todosListado.recetas, todosListado.nrecetas);
  await buscarUtensilios(todosListado.utensilios, todosListado.nutensilios);
  return todosListado.recetas;
}

class Listado {
  Listado(
       this.recetas,
       this.nrecetas,
       this.dietas,
       this.ndietas,
       this.ingredientes,
       this.ningredientes,
       this.tipos,
       this.ntipos,
       this.regiones,
       this.nregion,
       this.utensilios,
       this.nutensilios);

  List<Receta> recetas;
  List<String> nrecetas;
  List<Dieta> dietas;
  List<String> ndietas;
  List<Ingrediente> ingredientes;
  List<String> ningredientes;
  List<Tipo> tipos;
  List<String> ntipos;
  List<Region> regiones;
  List<String> nregion;
  List<Utensilio> utensilios;
  List<String> nutensilios;
}
