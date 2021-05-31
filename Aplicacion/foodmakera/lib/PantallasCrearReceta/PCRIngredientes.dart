import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Pantallas/PantallaIngredientes.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

bool conp = false;
//Ingredientes seleccionados
List<Ingrediente> ingredientesC = [];
//Nombre de ingredientes seleccionados
List<String> ingredientesS = [];
//Item que se muestran en las listas
List<Item> itemcreados = [];
//Todos los ingredientes
List<Ingrediente> todosIngredientes=[];
TextStyle estiloCartas=TextStyle(fontSize: 14);

class Item {
  Item(
      { this.ingrediente,
        this.controladorcantidad,
        this.controladormedida,
        this.key});
  Ingrediente ingrediente;
  TextEditingController controladorcantidad;
  TextEditingController controladormedida;
  int cantidad;
  String medida;
  String key;
}

class PCRIngredientes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoPCRIngredientes();
}

//Se contruyen los elementos visuales de forma general
class EstadoPCRIngredientes extends State<PCRIngredientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            child: Center(child: Text("Ingredientes agregados", style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)),
          ),
          //Se crea el boton para agregar lo ingredientes
          Container(
            height: 470,
            width: 200,
            //Se muestran los ingredientes que el usuario ha seleccionado
            child: listaIngrediente(),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  traerCIngredientes();
                });
              },
              child: Text('Agregar Ingedientes')),
          //El boton desde el cual se puede crear nuevos ingredientes
          ElevatedButton(
            onPressed: () {
              CrearIngredienteDialogo(context);
            },
            child: Text('Crear Ingrediente'),
          )
        ],
      ),
    );
  }

  //************************* Toda la funcionalidad de la manipulacion de ingredientes **************
  //Busca los ingredientes en la base de datos y los almacena
  traerCIngredientes() async {
    await obtenerIngredientes(todosIngredientes);
    ingredientesS = convertirtoString(ingredientesC);
    List<Ingrediente> traer =
        await PantallaIngredientes(context, ingredientesS);
    List<String> listaIngreTraidos =convertirtoString(traer);
    llenarItems(listaIngreTraidos,traer);
  }

  //Con el nombre de un ingrediente lo busca en la lista de items
  String buscarenItems(String nombre) {
    for (int i = 0; i < itemcreados.length; i++) {
      if (itemcreados[i].ingrediente.nombre.compareTo(nombre) == 0) {
        return itemcreados[i].key;
      }
    }
    return null;
  }

  //Llena los items
  llenarItems(List<String> nuevos, List<Ingrediente> ingredientesT) {
    List<String> union=[];
    List<String> aux=[];
    aux.addAll(ingredientesS);
    for(int i=0; i < aux.length; i++){
      print(i);
      if(nuevos.indexOf(aux[i]) == -1 ){
        if(buscarenItems(aux[i]) != null){
          Ingrediente buscado=buscarenIngredientes(aux[i], todosIngredientes);
          if(buscado != null){
            eliminar(buscarenItems(buscado.nombre));
            ingredientesC.remove(buscado);
          }
        }
      }else{
         union.add(aux[i]);
      }
    }

    for(int i=0; i < nuevos.length; i++){
      if(aux.indexOf(nuevos[i]) == -1){
         union.add(nuevos[i]);
         Ingrediente nuevo=buscarenIngredientes(nuevos[i], todosIngredientes);
         if(nuevo != null){
           Item nitem=crearIngrediente(nuevo);
           itemcreados.add(nitem);
           ingredientesC.add(nuevo);
         }
      }
    }
    ingredientesS=union;
    setState(() {
      listaIngrediente.icreado = itemcreados;
    });

  }
}


//Cre un Item con un objeto tipo Ingrediente
Item crearIngrediente(Ingrediente ingrediente){
  Item I = Item(
      ingrediente: ingrediente,
      controladorcantidad: TextEditingController(),
      controladormedida: TextEditingController(),
      key: ingrediente.objectId);
  return I;
}

List<String> convertirtoString(List<Ingrediente> ingredien) {
  List<String> nombres = [];
  for (int i = 0; i < ingredien.length; i++) {
    nombres.add(ingredien[i].nombre);
  }
  return nombres;
}

 String buscarKeyItems(Ingrediente ingrediente){
  for(int i=0; i < itemcreados.length; i++){
    if(ingrediente.nombre.compareTo(itemcreados[i].ingrediente.nombre) == 0){
      return itemcreados[i].key;
    }
  }
  return null;
 }
// Se busca entre los ingredientes
Ingrediente buscarenIngredientes(String nombre, List<Ingrediente> listaIngredientes) {
  for (int i = 0; i < listaIngredientes.length; i++) {
    if (listaIngredientes[i].nombre.compareTo(nombre) == 0) {
      return listaIngredientes[i];
    }
  }
  return null;
}
//******************************************************************

//*************  Funciones para crear un ingrediente *******************




// ************************ Funciones para mostrar la lista de ingredientes y manipularlos ****************
class listaIngrediente extends StatefulWidget {
  static List<Item> icreado = [];
  @override
  State<StatefulWidget> createState() => estadoListaIngredientes();
}

// se crea la lista de ingredientes
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
                  height: 50,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10),
                      //Muestra el nombre del ingrediente
                      Text(listaIngrediente.icreado[index].ingrediente.nombre,style: estiloCartas,),
                      //Muestra el cuadro de texto para colocar la cantidad
                      SizedBox(width: 15),
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(hintText: "Cantidad", hintStyle: estiloCartas),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]*\.?[0-9]*'))],
                          maxLines: 1,
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
                      SizedBox(width: 15),
                      //Muestra el cuadro de texto para coloar la medida
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: TextField(
                          onChanged: (text) {
                            listaIngrediente.icreado[index].medida = text;
                          },
                          onEditingComplete: () {
                            listaIngrediente.icreado[index].medida =
                                listaIngrediente
                                    .icreado[index].controladormedida.text;
                          },
                          decoration: InputDecoration(hintText: "Medida", hintStyle: estiloCartas),
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
}

//Permite eliminar un ingrediente de la lista
void eliminar(String key) {
  Item item;
  for (int i = 0; i < itemcreados.length; i++) {
    if (listaIngrediente.icreado[i].key.compareTo(key) == 0) {
      item = itemcreados[i];
    }
  }
    ingredientesC.remove(item.ingrediente);
    ingredientesS.remove(item.ingrediente.nombre);
    listaIngrediente.icreado.remove(item);
}

//******************************************************************************

//***************************** Funcionalidad de creacion de ingrediente en la base de datos ******************

//Muestra el cuadro de  dialogo para la creacion
CrearIngredienteDialogo(BuildContext context) async {
  TextEditingController controladornombre = TextEditingController();
  TextEditingController controladormedida = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
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
                  crearIngredienteDB(
                      controladornombre, controladormedida, context);
                }
              },
              child: Center(child: Text('Crear Ingrediente')),
            )
          ]),
        );
      });
}

//Compara con los ingredientes crados en la base de datos con el nuevo
comprobar(String nombreaIngrediente) async {
  bool encontro = false;
  List<String> todosIngrediente = [];
  List<Ingrediente> ingedientes = [];
  ingredientes = await obtenerIngredientes(ingedientes);
  todosIngrediente = convertirtoString(ingedientes);
  for (int i = 0; i < todosIngrediente.length; i++) {
    if (todosIngrediente[i]
            .toLowerCase()
            .compareTo(nombreaIngrediente.toLowerCase()) ==
        0) {
      encontro = true;
    }
  }
  conp = encontro;
}

// Crea el ingrediente en la base de datos
crearIngredienteDB(TextEditingController nombre, TextEditingController medida,
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
  todosIngredientes=[];
  await obtenerIngredientes(todosIngredientes);
}
// ***************************************************


// Permite crear cualquier aviso para ser mostrado
crearAviso(BuildContext context, String info) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Center(
                child: Text('Informacion'),
              )
            ],
          ),
          content: Center(
            child: Text(info),
          ),
        );
      });
}
