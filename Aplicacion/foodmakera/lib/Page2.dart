import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'Consultas.dart';
import 'Clases/Dieta.dart';
import 'Config/ClienteGraphQL.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'Clases/Dieta.dart';
import 'Clases/Ingredientes.dart';
import 'Region.dart';
import 'TipoDeComida.dart';
import 'Utencilios.dart';

class Page2 extends StatelessWidget {
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
            icon: Icon(Icons.fastfood),
            onPressed:(){
              Ingredientes().crearVentanaDialogo(context);
            }
          ),
          //Necesitamos la base de datos
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      drawer: Drawer(
          child: ListView(
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    children: [
                      Text('Filtros'),
                      SizedBox(
                        height: 30,
                        width: double.maxFinite,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: Colors.lightGreen),
                ),
                listadosDinamicos() // Se llama a la funcion dinamica que crea las listas desplegables
              ]
          )
      ),
      body: Container(
        child: Center(
          child: Text(
            'Pagina de mostrar tendencias o algo ',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

}

class listadosDinamicos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EstadoListados();
}

class EstadoListados extends State<listadosDinamicos> { // Se crea los estados de los listados dinamicos
  final List<Item> infoPanels=listadosfiltros(); //Se carga la informacion de los filtros


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child:_construirPanel()
      ),
    );
  }

  Widget _construirPanel(){
    List<String> aux = List<String>();
    return ExpansionPanelList( //Se crea cada uno de los paneles o listas
      expansionCallback: (int index, bool isExpanded){
        setState(() {
          infoPanels [index].isExpanded = !isExpanded;
        });
      },
      children: infoPanels.map<ExpansionPanel>((Item item)
      {
       return ExpansionPanel(
           headerBuilder: (BuildContext context, bool isExpanded){
             return ListTile(
               leading: item.icono,
               title: Text(item.headerValue)
             );
           },
           isExpanded: item.isExpanded,
           body: CheckboxGroup(
             labels: item.valores,
             onSelected:(List selected) => setState((){
                 aux = selected;
               }),
           )
       );
      }).toList(), // toList() permite que se haga para cada elemento de la lista
    );
  }
}

class Item { //Se crea la clase que contiene toda la informacion para crear las listas desplegables
  Item({
    @required this.headerValue,
    @required this.icono,
    this.valores,
    this.isExpanded=false,
  });
  Icon icono;
  List<String> valores;
  String headerValue;
  bool isExpanded;
}

 List<Item> listadosfiltros(){ //Se llena la informacion de los filtros
  List<String> nombre=['Utensilio','Tipo','Region','Dieta'];
  List<Icon> iconos=[Icon(Icons.food_bank_outlined),Icon(Icons.cake_outlined),
    Icon(Icons.add_location),Icon(Icons.directions_run)];
  List<Item> items= List<Item>();
  Item i;
   for(int i=0; i < nombre.length; i++){
   items.add(Item(headerValue:nombre[i],icono: iconos[i],valores: ['Hola']));
   }
   setValoresFiltroDieta(items,nombre);
  return items;
 }

 void setValoresFiltroDieta(List<Item> infoPaneles, List<String> nombrePaneles) async{
    List<String> nombres=List<String>();
    ClienteGraphQL configCliente = ClienteGraphQL();
    GraphQLClient cliente = configCliente.myClient();
    List<Dieta> totalDietas = List<Dieta>();
    QueryResult results= await cliente.query(
      QueryOptions(documentNode: gql(Consultas().query)));
    if(results.hasException){
      print(results.exception);
    }else if (results.data.isNotEmpty){
       setValoresFiltrosDieta(totalDietas, nombres, results);
      }
    infoPaneles[nombrePaneles.indexOf('Dieta')].valores=nombres;
    }

    void setValoresFiltrosDieta(List<Dieta> dietas, List<String> nombredietas, QueryResult results) {
      List ListaRespuestas=results.data['dietas']['edges'];
      for(int i=0; i < ListaRespuestas.length; i++) {
        nombredietas.add(ListaRespuestas[i]['node']['nombre']);
        Dieta dieta= Dieta(ListaRespuestas[i]['node']['id_dieta'],
            ListaRespuestas[i]['node']['nombre']);
        dieta.objectId=ListaRespuestas[i]['node']['objectId'];
        dietas.add(dieta);
      }
    }




