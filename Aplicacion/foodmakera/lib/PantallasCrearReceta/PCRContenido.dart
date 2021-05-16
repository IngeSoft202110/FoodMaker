import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../Clases/Dieta.dart';
import '../Clases/Receta.dart';
import '../Clases/Region.dart';
import '../Clases/Tipo.dart';
import '../Clases/Utensilio.dart';
import '../Config/ClienteGraphQL.dart';
import '../Config/QueryConversion.dart';
import '../PBuscarRecetas.dart';

Atributos todosAtributos = Atributos(
    List<Dieta>(),
    List<String>(),
    List<Tipo>(),
    List<String>(),
    List<Region>(),
    List<String>(),
    List<Utensilio>(),
    List<String>());
String seleccionDieta;
String seleccionTipo;
String seleccionRegion;
String seleccionUtensilio;
bool variableUtensilio;
bool variableTipo;
bool variableDieta;
bool variableRegion;

TextEditingController controladorRegion = TextEditingController();
TextEditingController controladorTipo = TextEditingController();
TextEditingController controladorDieta = TextEditingController();
TextEditingController controladorUtensilio = TextEditingController();
TextEditingController controladorUtenDes = TextEditingController();

class PCRContenido extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstruccionCuerpo(context));
  }
}

FutureBuilder ConstruccionCuerpo(BuildContext context) {
  return FutureBuilder(
      future: buscarInfo(todosAtributos),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.hasError.toString());
          return construccionBody();
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return construccionBody();
        }
      });
}

class construccionBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoBody();
}

class EstadoBody extends State<construccionBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Center(
          child: Text(
            'Región de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione la región de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.nregion.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      ElevatedButton(
          onPressed: () {
            crearRegion(context);
          },
          child: Text('Crear Región')),
      Center(
          child: Text(
            'Tipo de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el tipo de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.ntipos.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      ElevatedButton(
          onPressed: () {
            crearTipo(context);
          },
          child: Text('Crear Tipo')),
      Center(
          child: Text(
            'Dieta de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione la dieta de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.ndietas.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      ElevatedButton(
          onPressed: () {
            crearDieta(context);
          },
          child: Text('Crear Dieta')),
      Center(
          child: Text(
            'Utensilio de la receta: ',
            style: TextStyle(),
          )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el utensilio de la receta'),
            value: seleccionRegion,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue) {
              setState(() {
                seleccionRegion = newValue;
              });
            },
            items: todosAtributos.nutensilios.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      ElevatedButton(
          onPressed: () {
            crearUten(context);
          },
          child: Text('Crear Utensilio')),
    ]);
  }
}

crearRegion(BuildContext context){
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return construcADReg();
    }
  );
}

class construcADReg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoAlertReg();
}

class estadoAlertReg extends State<construcADReg> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: Text('Crear Región'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Nombre de la región.'),
              TextField(
                controller: controladorRegion,
              ),
            ],

          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Crear'),
            onPressed: () {
              agregarRegion(controladorRegion.text);
              Navigator.of(context).pop();
            },
          ),
        ],
    );
  }
  void agregarRegion(String nombre) async{
    ClienteGraphQL configCliente = ClienteGraphQL();
    GraphQLClient cliente = configCliente.myClient();
    final crearRegion = ParseObject('Region')
      ..set('nombre', nombre);
    var respuesta = await crearRegion.save();
    if (respuesta.success) {
      //AlertaError(context, "Se creo la región exitosamente.");
    }
  }

}

crearTipo(BuildContext context){
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADTipo();
      }
  );
}

class construcADTipo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoAlertTipo();
}

class estadoAlertTipo extends State<construcADTipo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Crear Tipo'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Nombre del Tipo.'),
            TextField(
              controller: controladorTipo,
            ),
          ],

        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Crear'),
          onPressed: () {
            agregarTipo(controladorTipo.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );

  }
  void agregarTipo(String nombre) async{
    ClienteGraphQL configCliente = ClienteGraphQL();
    GraphQLClient cliente = configCliente.myClient();
    final crearTipo = ParseObject('Tipo')
      ..set('nombre', nombre);
    var respuesta = await crearTipo.save();
    if (respuesta.success) {
      //AlertaError(context, "Se creo el tipo exitosamente.");
    }
  }
}

crearDieta(BuildContext context){
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADDieta();
      }
  );
}

class construcADDieta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoAlertDieta();
}

class estadoAlertDieta extends State<construcADDieta> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Crear Dieta'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Nombre del Dieta.'),
            TextField(
              controller: controladorDieta,
            ),
          ],

        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Crear'),
          onPressed: () {
            agregarDieta(controladorDieta.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void agregarDieta(String nombre) async{
    ClienteGraphQL configCliente = ClienteGraphQL();
    GraphQLClient cliente = configCliente.myClient();
    final crearDieta = ParseObject('Dieta')
      ..set('nombre', nombre);
    var respuesta = await crearDieta.save();
    if (respuesta.success) {
      //AlertaError(context, "Se creo la dieta exitosamente.");
    }
  }
}

crearUten(BuildContext context){
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADUten();
      }
  );
}

class construcADUten extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoAlertUten();
}

class estadoAlertUten extends State<construcADUten> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text('Crear Utensilio'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Nombre del Utensilio.'),
            TextField(
              controller: controladorUtensilio,
            ),
            Text('Descripción del Utensilio.'),
            TextField(
              controller: controladorUtenDes,
            ),
          ],

        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Crear'),
          onPressed: () {
            agregarUtensilio(controladorUtensilio.text, controladorUtenDes.text, todosAtributos.nutensilios);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  void agregarUtensilio(String nombre, String descripcion, List<String> nombres) async{
    ClienteGraphQL configCliente = ClienteGraphQL();
    GraphQLClient cliente = configCliente.myClient();
    valUtensilio(nombre, nombres);
    if (variableUtensilio == true){
      final crearUtensilio = ParseObject('Utensilio')
        ..set('nombre', nombre)..set('descripcion', descripcion);
      var respuesta = await crearUtensilio.save();
      if (respuesta.success) {
        AlertaError(context, "Se creo el utensilio exitosamente.");
      }
    }
    else {
      AlertaError(context, "Ese Utensilio ya existe.");
    }
  }

  void valUtensilio(nombre, nombres) async{
    variableUtensilio = await validarUtensilio(nombre, nombres);
    print (variableUtensilio);
  }

  bool validarUtensilio(String nombre, List<String> nombres){
    for(int i = 0; i < nombres.length; i++){
      if(nombre == nombre[i]){
        print('Ya esta');
        return false;
      }
    }
    return true;
  }

  AlertaError(BuildContext context, String texto) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text(""),
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
}


Future<Atributos> buscarInfo(Atributos todosAtributos) async {
  await buscarTipos(todosAtributos.tipos, todosAtributos.ntipos);
  await buscarRegiones(todosAtributos.regiones, todosAtributos.nregion);
  await buscarDietas(todosAtributos.dietas, todosAtributos.ndietas);
  await buscarUtensilios(todosAtributos.utensilios, todosAtributos.nutensilios);
  return todosAtributos;
}

void buscarTipos(List<Tipo> tipos, List<String> ntipos) async {
  await obtenerTipo(tipos);
  for (int i = 0; i < tipos.length; i++) {
    ntipos.add(tipos[i].nombre);
  }
}

void buscarRegiones(List<Region> regiones, List<String> nregion) async {
  await obtenerRegiones(regiones);
  for (int i = 0; i < regiones.length; i++) {
    nregion.add(regiones[i].nombre);
  }
}

void buscarDietas(List<Dieta> dietas, List<String> ndietas) async {
  await obtenerDietas(dietas);
  for(int i = 0; i < dietas.length; i++){
    ndietas.add(dietas[i].nombre);
  }
}

void buscarUtensilios(List<Utensilio> utensilios, List<String> nutensilios) async {
  await obtenerUtensilios(utensilios);
  for (int i = 0; i < utensilios.length; i++) {
    nutensilios.add(utensilios[i].nombre);
  }
}

class Atributos {
  Atributos(
      @required this.dietas,
      @required this.ndietas,
      @required this.tipos,
      @required this.ntipos,
      @required this.regiones,
      @required this.nregion,
      @required this.utensilios,
      @required this.nutensilios);

  List<Dieta> dietas;
  List<String> ndietas;
  List<Tipo> tipos;
  List<String> ntipos;
  List<Region> regiones;
  List<String> nregion;
  List<Utensilio> utensilios;
  List<String> nutensilios;
}