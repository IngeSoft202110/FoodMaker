import 'package:flutter/material.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'Clases/Ingrediente.dart';
import 'Clases/Receta.dart';
import 'Config/QueryConversion.dart';
import 'Pantallas/PantallaIngredientes.dart';
import 'Clases/Dieta.dart';
import 'Clases/Region.dart';
import 'Clases/Tipo.dart';
import 'Clases/Utensilio.dart';
import 'Pantallas/ListaRecetas.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

//Se almacenan todas las recetas para se usadas en los diferentes metodos
List<Receta> todasRecetas = List<Receta>();
//Se almacenan todo los valores seleccionados en los filtros
List<List<String>> seleccionCheckBox = List<List<String>>();
List<Ingrediente> ingreSleccionados = List<Ingrediente>();

class PBuscarRecetas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Se inicializan las listas de seleccion de los filtros
    seleccionCheckBox.add(List<String>());
    seleccionCheckBox.add(List<String>());
    seleccionCheckBox.add(List<String>());
    seleccionCheckBox.add(List<String>());
    //Permite esperar hasta que traiga todas las recetas
    return FutureBuilder(
      future: buscaryTraerReceta(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          todasRecetas = List<Receta>();
          return BuscarRecetas();
          //Center(
          //  child: Text('Error: ${snapshot.hasError.toString()}'));
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          todasRecetas = snapshot.data;
          return BuscarRecetas();
        }
      },
    );
  }
}

class BuscarRecetas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoRecetas();
}

class EstadoRecetas extends State<BuscarRecetas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '¿Qué deseas Buscar?',
            textAlign: TextAlign.center,
          ),
          //Boton de Busqueda
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        drawer: Drawer(
            child: ListView(children: <Widget>[
          SizedBox(
            height: 120,
            child: Container(
                color: Colors.lightGreen,
                child: Center(
                    child: Text(
                  'Filtros',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ))),
          ),
          //Boton para los ingredientes
          SizedBox(
            height: 60,
            child: TextButton(
                onPressed: () {
                  devolverListaIngredientes();
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.fastfood,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Text('Ingredientes', style: TextStyle(color: Colors.black))
                  ],
                )),
          ), // Se llama a la funcion dinamica que crea las listas desplegables
          FiltrosDinamicos(),
          SizedBox(
            height: 60,
            child: TextButton(
                // Boton para buscar con los filtros
                onPressed: () {
                  obtenerRecetas(todasRecetas);
                  setState(() {
                    actualizarBusqueda();
                  });
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Text('Aplicar Filtros',
                        style: TextStyle(color: Colors.black))
                  ],
                )),
          )
        ])),
        body: actualizarBusqueda());
  }

  devolverListaIngredientes() async {
    ingreSleccionados = await PantallaIngredientes(context, []);
  }
}

class actualizarBusqueda extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoBusqueda();
}

class EstadoBusqueda extends State<actualizarBusqueda> {
  @override
  Widget build(BuildContext context) {
    List<String> ingredientes = List<String>();
    if ((seleccionCheckBox[0].length == 0 || seleccionCheckBox[0] == null) &&
            (seleccionCheckBox[1].length == 0 ||
                seleccionCheckBox[1] == null) &&
            (seleccionCheckBox[2].length == 0 ||
                seleccionCheckBox[2] == null) &&
            (seleccionCheckBox[3].length == 0 ||
                seleccionCheckBox[3] == null) &&
            ingredientes.length == 0 ||
        ingredientes == null) {
      return mostrarRecetas(todasRecetas);
    }
    List<Receta> recetasFiltradas = List<Receta>();
    recetasFiltradas = busquedaRecetas(
        seleccionCheckBox[0],
        seleccionCheckBox[1],
        seleccionCheckBox[2],
        seleccionCheckBox[3],
        ingredientes,
        todasRecetas);
    return mostrarRecetas(recetasFiltradas);
  }
}

class FiltrosDinamicos extends StatefulWidget {
  List<Item> infoPanels =
      listadosfiltros(); //Se carga la informacion de los filtros
  @override
  State<StatefulWidget> createState() => EstadoFiltros();
}

class EstadoFiltros extends State<FiltrosDinamicos> {
  // Se crea los estados de los listados dinamicos

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(child: _construirPanel()),
    );
  }

  //Construye las litas desplegables de los filtros
  Widget _construirPanel() {
    return ExpansionPanelList(
      //Se crea cada uno de los paneles o listas
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.infoPanels[index].isExpanded = !isExpanded;
        });
      },
      children: widget.infoPanels.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                  leading: item.icono, title: Text(item.headerValue));
            },
            isExpanded: item.isExpanded,
            body: CheckboxGroup(
              labels: item.valores,
              checked: seleccionCheckBox[item.index],
              onSelected: (List select) => setState(() {
                item.seleccionados = select;
                seleccionCheckBox[item.index] = select;
              }),
            ));
      }).toList(), // toList() permite que se haga para cada elemento de la lista
    );
  }
}

//Envia la lista de recetas para que se muestren en las carts
Widget mostrarRecetas(List<Receta> recetass) {
  return Listadinamica(recetass);
}

class Item {
  //Se crea la clase que contiene toda la informacion para crear las listas desplegables
  Item(
      {@required this.headerValue,
      @required this.icono,
      this.valores,
      this.isExpanded = false,
      this.index});
  Icon icono;
  int index;
  List<String> valores;
  List<String> seleccionados;
  String headerValue;
  bool isExpanded;
}

List<Item> listadosfiltros() {
  List<Item> items = List<Item>();
  //Se llena la informacion de los filtros
  List<String> nombre = ['Utensilio', 'Tipo', 'Region', 'Dieta'];
  List<Icon> iconos = [
    Icon(Icons.food_bank_outlined),
    Icon(Icons.cake_outlined),
    Icon(Icons.add_location),
    Icon(Icons.directions_run)
  ];
  for (int i = 0; i < nombre.length; i++) {
    items.add(
      Item(headerValue: nombre[i], icono: iconos[i], valores: [''], index: i),
    );
    setValoresFiltroDieta(items, nombre);
    setValoresFiltroRegion(items, nombre);
    setValoresFiltroTipo(items, nombre);
    setValoresFiltroUtensilio(items, nombre);
  }
  return items;
}

// ------------------ Busqueda y seteo de los filtros

//Setea los valores del filtro dietas en el item
void setValoresFiltroDieta(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<Dieta> dietas = List<Dieta>();
  List<String> nombres = List<String>();
  await obtenerDietas(dietas);
  for (int i = 0; i < dietas.length; i++) {
    nombres.add(dietas[i].nombre);
  }
  infoPaneles[nombrePaneles.indexOf('Dieta')].valores = nombres;
}

//Setea los valores del filtro tipo en el item
void setValoresFiltroTipo(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<Tipo> tipos = List<Tipo>();
  List<String> nombres = List<String>();
  await obtenerTipo(tipos);
  for (int i = 0; i < tipos.length; i++) {
    nombres.add(tipos[i].nombre);
  }
  infoPaneles[nombrePaneles.indexOf('Tipo')].valores = nombres;
}

//Setea los valores del filtro regiones en el item
void setValoresFiltroRegion(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<String> nombres = List<String>();
  List<Region> totalRegiones = List<Region>();
  await obtenerRegiones(totalRegiones);
  for (int i = 0; i < totalRegiones.length; i++) {
    nombres.add(totalRegiones[i].nombre);
  }
  infoPaneles[nombrePaneles.indexOf('Region')].valores = nombres;
}

//Setea los valores del filtro utensilio en el item
void setValoresFiltroUtensilio(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<Utensilio> utensilios = List<Utensilio>();
  List<String> nombres = List<String>();
  await obtenerUtensilios(utensilios);
  for (int i = 0; i < utensilios.length; i++) {
    nombres.add(utensilios[i].nombre);
  }
  infoPaneles[nombrePaneles.indexOf('Utensilio')].valores = nombres;
}

//--------------------------------------------------------------------

//Funcion que hace la busqueda
List<Receta> busquedaRecetas(
    List<String> itemUtensilio,
    List<String> itemTipo,
    List<String> itemRegion,
    List<String> itemDieta,
    List<String> itemIngrediente,
    List<Receta> recetasTodas) {
  //Optimizar :) Está muy largo
  List<Receta> recetasB = recetasTodas;
  int cont;

  bool revision;
  if (itemIngrediente.length > 0) {
    List<Receta> aux = List<Receta>();
    for (int i = 0; i < recetasB.length; i++) {
      cont = 0;
      for (int j = 0; j < itemIngrediente.length; j++) {
        for (int k = 0; k < recetasB[i].ingredientes.length; k++) {
          if (itemIngrediente[j]
                  .compareTo(recetasB[i].ingredientes[k].nombre) ==
              0) {
            cont++;
          }
        }
      }
      if (cont == itemIngrediente.length) {
        aux.add(recetasB.elementAt(i));
      }
    }
    recetasB = aux;
  }

  if (itemUtensilio.length > 0) {
    List<Receta> aux = List<Receta>();
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemUtensilio.length; j++) {
        for (int k = 0; k < recetasB[i].utensilios.length; k++) {
          if (itemUtensilio[j].compareTo(recetasB[i].utensilios[k].nombre) ==
              0) {
            revision = true;
          }
        }
      }
      if (revision == true) {
        aux.add(recetasB.elementAt(i));
      }
    }
    recetasB = aux;
  }

  if (itemRegion.length > 0) {
    List<Receta> aux = List<Receta>();
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemRegion.length; j++) {
        if (itemRegion[j].compareTo(recetasB[i].region.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == true) {
        aux.add(recetasB.elementAt(i));
      }
    }
    recetasB = aux;
  }
  if (itemTipo.length > 0) {
    List<Receta> aux = List<Receta>();
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemTipo.length; j++) {
        if (itemTipo[j].compareTo(recetasB[i].tipo.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == true) {
        aux.add(recetasB.elementAt(i));
      }
    }
    recetasB = aux;
  }

  if (itemDieta.length > 0) {
    List<Receta> aux = List<Receta>();
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemDieta.length; j++) {
        if (itemDieta[j].compareTo(recetasB[i].dieta.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == true) {
        aux.add(recetasB.elementAt(i));
      }
    }
    recetasB = aux;
  }
  if (recetasB == null || recetasB.length == 0) {
    return List<Receta>();
  } else {
    return recetasB;
  }
}

Future<List<Receta>> buscaryTraerReceta() async {
  List<Receta> recetas = List<Receta>();
  await obtenerRecetas(recetas);
  return recetas;
}


