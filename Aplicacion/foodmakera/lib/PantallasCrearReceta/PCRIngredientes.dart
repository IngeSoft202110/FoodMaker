import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Pantallas/PantallaIngredientes.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

bool conp = false;
List<Ingrediente> ingredientesC = [];
List<String> ingredientesS = [];
List<Item> itemcreados = [];

class PCRIngredientes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoPCRIngredientes();
}

class EstadoPCRIngredientes extends State<PCRIngredientes> {
  @override
  Widget build(BuildContext context) {
    ingredientesC = [];
    itemcreados = [];
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                setState(() {
                  traerCIngredientes();
                });
              },
              child: Text('Agregar Ingedientes')),
          Container(
            height: 500,
            width: 200,
            child: listaIngrediente(),
          ),
          ElevatedButton(
            onPressed: () {
              CrearIngrediente(context);
            },
            child: Text('Crear Ingrediente'),
          )
        ],
      ),
    );
  }

  traerCIngredientes() async {
    List<Ingrediente> traer =
        await PantallaIngredientes(context, ingredientesS);
    for (int i = 0; i < traer.length; i++) {
      if (ingredientesC.indexOf(traer[i]) == -1) {
        ingredientesC.add(traer[i]);
      }
    }
    ingredientesS = convertirtoString(ingredientesC);
    llenarItems();
  }

  bool buscar(String nombre) {
    for (int i = 0; i < itemcreados.length; i++) {
      if (itemcreados[i].ingrediente.nombre.compareTo(nombre) == 0) {
        return true;
      }
    }
    return false;
  }

  llenarItems() {
    for (int i = 0; i < ingredientesC.length; i++) {
      Item I = Item(
          ingrediente: ingredientesC[i],
          controladorcantidad: TextEditingController(),
          controladormedida: TextEditingController(),
          key: ingredientesC[i].objectId);
      if (buscar(I.ingrediente.nombre) == false) {
        itemcreados.add(I);
      }
    }
    listaIngrediente.icreado = itemcreados;
  }
}
//Mirara sib funciona

class listaIngrediente extends StatefulWidget {
  static List<Item> icreado = [];
  @override
  State<StatefulWidget> createState() => estadoListaIngredientes();
}

List<String> convertirtoString(List<Ingrediente> ingredien) {
  List<String> nombres = List<String>();
  for (int i = 0; i < ingredien.length; i++) {
    nombres.add(ingredien[i].nombre);
  }
  return nombres;
}

class estadoListaIngredientes extends State<listaIngrediente> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listaIngrediente.icreado.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: Key(listaIngrediente.icreado[index].key),
              onDismissed: (direccion) {
                eliminar(listaIngrediente.icreado[index].key);
              },
              child: Card(
                child: Container(
                  width: 300,
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      //Muestra el nombre del ingrediente
                      Text(listaIngrediente.icreado[index].ingrediente.nombre),
                      //Muestra el cuadro de texto para colocar la cantidad
                      SizedBox(width: 20),
                      SizedBox(
                        width: 80,
                        height: 20,
                        child: TextField(
                          decoration: InputDecoration(hintText: "Cantidad"),
                          onEditingComplete: () {
                            listaIngrediente.icreado[index].cantidad =
                                int.parse(listaIngrediente
                                    .icreado[index].controladorcantidad.text);
                          },
                          onChanged: (texto) {
                            listaIngrediente.icreado[index].cantidad =
                                int.parse(texto);
                          },
                          keyboardType: TextInputType.number,
                          controller: listaIngrediente
                              .icreado[index].controladorcantidad,
                        ),
                      ),
                      SizedBox(width: 20),
                      //Muestra el cuadro de texto para coloar la medida
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: TextField(
                          onChanged: (text) {
                            listaIngrediente.icreado[index].medida = text;
                          },
                          onEditingComplete: () {
                            listaIngrediente.icreado[index].medida =
                                listaIngrediente
                                    .icreado[index].controladormedida.text;
                          },
                          decoration: InputDecoration(hintText: "Medida"),
                          controller:
                              listaIngrediente.icreado[index].controladormedida,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void eliminar(String key) {
    Item item;
    for (int i = 0; i < itemcreados.length; i++) {
      if (listaIngrediente.icreado[i].key.compareTo(key) == 0) {
        item = itemcreados[i];
      }
    }
    if (ingredientesC.length == 1) ingredientesC = [];
    ingredientesC.remove(item.ingrediente);
    if (ingredientesS.length == 1) ingredientesS = [];
    ingredientesS = convertirtoString(ingredientesC);
    if (listaIngrediente.icreado.length == 1) listaIngrediente.icreado = [];
    listaIngrediente.icreado.remove(item);
  }
}

class Item {
  Item(
      {@required this.ingrediente,
      @required this.controladorcantidad,
      @required this.controladormedida,
      @required this.key});
  Ingrediente ingrediente;
  TextEditingController controladorcantidad;
  TextEditingController controladormedida;
  int cantidad;
  String medida;
  String key;
}

CrearIngrediente(BuildContext context) async {
  TextEditingController controladornombre = TextEditingController();
  TextEditingController controladormedida = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Center(
                child: Text('Crear Ingrediente'),
              )
            ],
          ),
          content: Column(children: <Widget>[
            TextField(
              controller: controladornombre,
              decoration: InputDecoration(hintText: "Nombre del Ingrediente"),
            ),
            TextField(
              controller: controladormedida,
              decoration: InputDecoration(
                  hintText: "Medida (Ej: Kilogramo, cucharadas, etc)"),
            ),
            ElevatedButton(
              onPressed: () async {
                await comprobar(controladornombre.text.toString());
                if (conp == true) {
                  crearAviso(context, "Este Ingrediente ya existe");
                } else {
                  print('no existe');
                  crearIngrediente(
                      controladornombre, controladormedida, context);
                }
              },
              child: Center(child: Text('Crear Ingrediente')),
            )
          ]),
        );
      });
}

comprobar(String nombreaIngrediente) async {
  bool encontro = false;
  List<String> todosIngrediente = List<String>();
  List<Ingrediente> ingedientes = List<Ingrediente>();
  ingredientes = await obtenerIngredientes(ingedientes);
  todosIngrediente = convertirtoString(ingedientes);
  for (int i = 0; i < todosIngrediente.length; i++) {
    if (todosIngrediente[i]
            .toLowerCase()
            .compareTo(nombreaIngrediente.toLowerCase()) ==
        0) {
      print("${todosIngrediente[i]} == ${nombreaIngrediente}");
      encontro = true;
    }
  }
  conp = encontro;
  print(conp);
}

crearIngrediente(TextEditingController nombre, TextEditingController medida,
    BuildContext context) async {
  final ingrediente = ParseObject('Ingrediente')
    ..set('nombre', nombre.text.toString())
    ..set('medida', medida.text.toString());
  var respuesta = await ingrediente.save();
  if (respuesta.success) {
    nombre.clear();
    medida.clear();
    crearAviso(context, "Ingrediente Creado");
  } else {
    crearAviso(context, "No se pudo crear el ingrediente");
  }
}

crearAviso(BuildContext context, String info) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
          title: Text('Informacion'),
          content: Center(
            child: Text(info),
          ),
        );
      });
}
