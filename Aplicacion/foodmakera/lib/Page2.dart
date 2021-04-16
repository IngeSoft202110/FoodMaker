import 'package:flutter/material.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'Pantallas/PantallaIngredientes.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Config/Consultas.dart';
import 'Clases/Dieta.dart';
import 'Clases/Region.dart';
import 'Clases/Tipo.dart';
import 'Clases/Utensilio.dart';
import 'Pantallas/ListaRecetas.dart';
import 'Config/ClienteGraphQL.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

List<Receta> otras = List<Receta>();
List<List<String>> seleccion = List<List<String>>();
List<String> vacia = List<String>();
List<Receta> aux=List<Receta>();



class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return todaPagina();
  }

}

class todaPagina extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoPagina();
}

class estadoPagina extends State<todaPagina> {
  @override
  Widget build(BuildContext context) {
    seleccion.add(vacia);
    seleccion.add(vacia);
    seleccion.add(vacia);
    seleccion.add(vacia);
    prueba(aux);
    for(int i=0; i < otras.length; i++){
      otras.removeAt(i);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '¿Qué deseas Buscar?',
          textAlign: TextAlign.center,
        ),
        //Boton de Busqueda
        actions: <Widget>[
          //Necesitamos la base de datos
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
        SizedBox(
          height: 60,
          child: TextButton(
              onPressed: () {
                pantallasi().pantalaya(context);
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
        ),listadosDinamicos()
        , // Se llama a la funcion dinamica que crea las listas desplegables
      ])),
      body:bodyDinamico(),
    );
  }
}


class bodyDinamico extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoBody();

}

class EstadoBody extends State<bodyDinamico> {

  @override
  Widget build(BuildContext context) {
    List<String> ingredientes=List<String>();
    prueba(aux);
    if(seleccion[0].length == 0 && seleccion[1].length == 0 &&  seleccion[2].length == 0 &&
        seleccion[3].length == 0 &&  ingredientes.length==0){
      return mostrarRecetas(aux);
    }

    List<Receta> recetasFiltradas = List<Receta>();
    recetasFiltradas = busquedaRecetas(seleccion[0], seleccion[1], seleccion[2],
        seleccion[3], ingredientes, aux);
    return mostrarRecetas(recetasFiltradas);
  }
}

class listadosDinamicos extends StatefulWidget {
  List<Item> infoPanels =
      listadosfiltros(); //Se carga la informacion de los filtros
  @override
  State<StatefulWidget> createState() => EstadoListados();
}

class EstadoListados extends State<listadosDinamicos> {
  // Se crea los estados de los listados dinamicos

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(child: _construirPanel()),
    );
  }

  Widget _construirPanel() {
    List<String> aux = List<String>();
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
              checked: seleccion[item.index],
              onSelected: (List select) => setState(() {
                item.seleccionados = select;
                seleccion[item.index] = select;
              }),
            ));
      }).toList(), // toList() permite que se haga para cada elemento de la lista
    );
  }
}

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
  //Se llena la informacion de los filtros
  List<String> nombre = ['Utensilio', 'Tipo', 'Region', 'Dieta'];
  List<Icon> iconos = [
    Icon(Icons.food_bank_outlined),
    Icon(Icons.cake_outlined),
    Icon(Icons.add_location),
    Icon(Icons.directions_run)
  ];
  List<Item> items = List<Item>();
  Item i;
  for (int i = 0; i < nombre.length; i++) {
    items.add(
      Item(
          headerValue: nombre[i],
          icono: iconos[i],
          valores: ['Hola'],
          index: i),
    );
  }
  setValoresFiltroDieta(items, nombre);
  setValoresFiltroRegion(items, nombre);
  setValoresFiltroTipo(items, nombre);
  setValoresFiltroUtensilio(items, nombre);

  return items;
}

void setValoresFiltroDieta(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<String> nombres = List<String>();
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  List<Dieta> totalDietas = List<Dieta>();
  QueryResult results =
      await cliente.query(QueryOptions(documentNode: gql(Consultas().query)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    setValoresFiltrosDieta(totalDietas, nombres, results);
  }
  infoPaneles[nombrePaneles.indexOf('Dieta')].valores = nombres;
}

void setValoresFiltrosDieta(
    List<Dieta> dietas, List<String> nombredietas, QueryResult results) {
  List ListaRespuestas = results.data['dietas']['edges'];
  for (int i = 0; i < ListaRespuestas.length; i++) {
    nombredietas.add(ListaRespuestas[i]['node']['nombre']);
    Dieta dieta = Dieta(ListaRespuestas[i]['node']['id_dieta'],
        ListaRespuestas[i]['node']['nombre']);
    dieta.objectId = ListaRespuestas[i]['node']['objectId'];
    dietas.add(dieta);
  }
}

void buscarIngredientes(QueryResult qr) async {
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarIngredientes)));
  qr = results;
}

void setValoresFiltroTipo(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<String> nombres = List<String>();
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  List<Tipo> totalTipos = List<Tipo>();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarTipos)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    setValoresFiltrosTipo(totalTipos, nombres, results);
  }
  infoPaneles[nombrePaneles.indexOf('Tipo')].valores = nombres;
}

void setValoresFiltrosTipo(
    List<Tipo> tipos, List<String> nombretipos, QueryResult results) {
  List ListaRespuestas = results.data['tipos']['edges'];
  for (int i = 0; i < ListaRespuestas.length; i++) {
    nombretipos.add(ListaRespuestas[i]['node']['nombre']);
    Tipo tipo = Tipo(ListaRespuestas[i]['node']['id_tipo'],
        ListaRespuestas[i]['node']['nombre']);
    tipo.objectId = ListaRespuestas[i]['node']['objectId'];
    tipos.add(tipo);
  }
}

void setValoresFiltroRegion(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<String> nombres = List<String>();
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  List<Region> totalRegiones = List<Region>();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarRegiones)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    setValoresFiltrosRegion(totalRegiones, nombres, results);
  }
  infoPaneles[nombrePaneles.indexOf('Region')].valores = nombres;
}

void setValoresFiltrosRegion(
    List<Region> regiones, List<String> nombreregiones, QueryResult results) {
  List ListaRespuestas = results.data['regions']['edges'];
  for (int i = 0; i < ListaRespuestas.length; i++) {
    nombreregiones.add(ListaRespuestas[i]['node']['nombre']);
    Region region = Region(ListaRespuestas[i]['node']['id_region'],
        ListaRespuestas[i]['node']['nombre']);
    region.objectId = ListaRespuestas[i]['node']['objectId'];
    regiones.add(region);
  }
}

void setValoresFiltroUtensilio(
    List<Item> infoPaneles, List<String> nombrePaneles) async {
  List<String> nombres = List<String>();
  ClienteGraphQL configCliente = ClienteGraphQL();
  GraphQLClient cliente = configCliente.myClient();
  List<Utensilio> totalUtensilios = List<Utensilio>();
  QueryResult results = await cliente
      .query(QueryOptions(documentNode: gql(Consultas().buscarUtensilios)));
  if (results.hasException) {
    print(results.exception);
  } else if (results.data.isNotEmpty) {
    setValoresFiltrosUtensilio(totalUtensilios, nombres, results);
  }
  infoPaneles[nombrePaneles.indexOf('Utensilio')].valores = nombres;
}

void setValoresFiltrosUtensilio(List<Utensilio> utensilios,
    List<String> nombreutensilios, QueryResult results) {
  List ListaRespuestas = results.data['utensilios']['edges'];
  for (int i = 0; i < ListaRespuestas.length; i++) {
    nombreutensilios.add(ListaRespuestas[i]['node']['nombre']);
    Utensilio utensilio = Utensilio(ListaRespuestas[i]['node']['id_utensilio'],
        ListaRespuestas[i]['node']['nombre']);
    utensilio.objectId = ListaRespuestas[i]['node']['objectId'];
    utensilios.add(utensilio);
  }
}

List<Receta> busquedaRecetas(
    List<String> itemUtensilio,
    List<String> itemTipo,
    List<String> itemRegion,
    List<String> itemDieta,
    List<String> itemIngrediente,
    List<Receta> recetasTodas) {
  //Optimizar :) Está muy largo
  List<Receta> recetasB = List<Receta>();
  print(itemDieta);
  print(itemUtensilio);
  print(itemRegion);
  print(itemTipo);
  recetasB = recetasTodas;
  int cont;
  bool revision;
  if (itemIngrediente.length > 0) {
    for (int i = 0; i < recetasB.length; i++) {
      cont = 0;
      for (int j = 0; j < itemIngrediente.length; j++) {
        for (int k = 0; k < recetasB[i].ingredientes.length; k++) {
          if (itemIngrediente[j].compareTo(recetasB[i].ingredientes[k].nombre) == 0) {
            cont++;
          }
        }
      }
      if (cont < itemIngrediente.length) {
        recetasB.removeAt(i);
      }
    }
  }
  if (itemRegion.length > 0) {
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemRegion.length; j++) {
        if (itemRegion[j].compareTo(recetasTodas[i].region.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == false) {
        recetasB.removeAt(i);
      }
      revision = false;
    }
  }
  if (itemTipo.length > 0) {
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemTipo.length; j++) {
        if (itemTipo[j].compareTo(recetasTodas[i].tipo.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == false) {
        recetasB.removeAt(i);
      }
      revision = false;
    }
  }
  if (itemUtensilio.length > 0) {
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemUtensilio.length; j++) {
        if (itemUtensilio[j].compareTo(recetasTodas[i].utensilio.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == false) {
        recetasB.removeAt(i);
      }
      revision = false;
    }
  }
  if (itemDieta.length > 0) {
    for (int i = 0; i < recetasB.length; i++) {
      revision = false;
      for (int j = 0; j < itemDieta.length; j++) {
        if (itemDieta[j].compareTo(recetasTodas[i].dieta.nombre) == 0) {
          revision = true;
        }
      }
      if (revision == false) {
        recetasB.removeAt(i);
      }
      revision = false;
    }
  }
  return recetasB;
}

prueba(List<Receta> rectasxs) async{
  await obtenerRecetas(rectasxs);
}
