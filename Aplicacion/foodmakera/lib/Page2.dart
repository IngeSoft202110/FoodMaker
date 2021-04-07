import 'package:flutter/material.dart';
import 'Consultas.dart';
import 'Clases/Dieta.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'Clases/Dieta.dart';
import 'Ingredientes.dart';
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
          //Necesitamos la base de datos
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      drawer: Drawer(
          child: Column(
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
                listadosDinamicos(), // Se llama a la funcion dinamica que crea las listas desplegables
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
  Object consultaDietas=Consultas().buscarDiestas();
  //List<String> nombreDietas = sacaNombreConsulta(Consultas().buscarDiestas()) as List<String>;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child:_construirPanel()
      ),
    );
  }

  Widget _construirPanel(){ // Se construyen los listados dinamicos
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
           body:Text("Ejemplo")
       );
      }).toList(), // toList() permite que se haga para cada elemento de la lista
    );
  }
}

class Item { //Se crea la clase que contiene toda la informacion para crear las listas desplegables
  Item({
    @required this.headerValue,
    @required this.icono,
    this.isExpanded=false,
  });
  Icon icono;
  Column valores;
  String headerValue;
  bool isExpanded;
}

 List<Item> listadosfiltros(){ //Se llena la informacion de los filtros
  List<String> nombre=['Utensilio','Tipo','Region','Dieta','Casos'];
  List<Icon> iconos=[Icon(Icons.food_bank_outlined),Icon(Icons.cake_outlined),
    Icon(Icons.add_location),Icon(Icons.directions_run), Icon(Icons.settings)];
  List<Item> items= List<Item>();
  Item i;
   for(int i=0; i < nombre.length; i++){
   items.add(Item(headerValue:nombre[i],icono: iconos[i]));
   }
  return items;
 }

 class checkBoxDinamico extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => EstadoCheckBox();
 }

class EstadoCheckBox extends State<checkBoxDinamico>{
  @override
  Widget build(BuildContext context) {

  }
}


List<String> sacaNombreConsulta(Object object) {

  List<Dieta> dietas = Consultas().buscarDiestas() as List<Dieta>;
  List<String> nombreDietas = List<String>();
  for(Dieta di in dietas){
    nombreDietas.add(di.nombre);
    print(di.nombre);
  }
  return nombreDietas;
}

