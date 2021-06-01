import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/RecetaCreacion.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '../Clases/Dieta.dart';
import '../Clases/Region.dart';
import '../Clases/Tipo.dart';
import '../Clases/Utensilio.dart';
import '../Config/QueryConversion.dart';
import 'PCRPrincipal.dart';

Atributos todosAtributos = Atributos(
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    []);
String seleccionDieta = "Ninguna";
String seleccionTipo = "Otro";
String seleccionRegion = "Otro";
String seleccionUtensilio = "Ninguno";
bool variableUtensilio = true;
bool variableTipo = true;
bool variableDieta = true;
bool variableRegion = true;

TextEditingController controladorRegion = TextEditingController();
TextEditingController controladorTipo = TextEditingController();
TextEditingController controladorDieta = TextEditingController();
TextEditingController controladorUtensilio = TextEditingController();
TextEditingController controladorUtenDes = TextEditingController();

class PCRContenido extends StatelessWidget {
  Verificar listaVerificar;
  PCRContenido(this.listaVerificar);
  @override
  Widget build(BuildContext context) {
    if(recetaCreacion.recetac == null){
      recetaCreacion.recetac=Receta(Dieta.vacia(), Region.vacio(), Tipo.vacio(), [], "", "", "", 0, 0, [], [], "", User.vacio(), []);
    }
    return Scaffold(body: ConstruccionCuerpo(context));
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
  static Atributos atributos;
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
          SizedBox(
            height: 10,
          ),
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
            items: construccionBody.atributos.nregion
                .map<DropdownMenuItem<String>>((String value) {
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
            setState(() {
              crearRegion(context);
            });
          },
          child: Text('Crear Región')
      ),
      SizedBox(
        height: 20,
      ),
      Center(
          child: Text(
        'Tipo de la receta: ',
        style: TextStyle(),
      )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el tipo de la receta'),
            value: seleccionTipo,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue2) {
              setState(() {
                seleccionTipo = newValue2;
              });
            },
            items: todosAtributos.ntipos
                .map<DropdownMenuItem<String>>((String value2) {
              return DropdownMenuItem<String>(
                value: value2,
                child: Text(value2),
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
      SizedBox(
        height: 20,
      ),
      Center(
          child: Text(
        'Dieta de la receta: ',
        style: TextStyle(),
      )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione la dieta de la receta'),
            value: seleccionDieta,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue3) {
              setState(() {
                seleccionDieta = newValue3;
              });
            },
            items: todosAtributos.ndietas
                .map<DropdownMenuItem<String>>((String value3) {
              return DropdownMenuItem<String>(
                value: value3,
                child: Text(value3),
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
      SizedBox(
        height: 20,
      ),
      Center(
          child: Text(
        'Utensilio de la receta: ',
        style: TextStyle(),
      )),
      Column(
        children: <Widget>[
          DropdownButton<String>(
            hint: Text('Seleccione el utensilio de la receta'),
            value: seleccionUtensilio,
            icon: const Icon(Icons.arrow_drop_down_circle_outlined),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            isExpanded: true,
            onChanged: (String newValue4) {
              setState(() {
                seleccionUtensilio = newValue4;
              });
            },
            items: todosAtributos.nutensilios
                .map<DropdownMenuItem<String>>((String value4) {
              return DropdownMenuItem<String>(
                value: value4,
                child: Text(value4),
              );
            }).toList(),
          )
        ],
      ),
      ElevatedButton(
          onPressed: () {
            crearUten(context);
          },
          child: Text('Crear Utensilio'))
    ]);
  }
}

crearRegion(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADReg();
      });
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
      title: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              }),
          Center(
            child: Text('Crear Región'),
          )
        ],
      ),
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
          onPressed: () async {
            await validarRegion(
                controladorRegion.text.toString(), todosAtributos.nregion);
            if (variableRegion == true) {
              await agregarRegion(controladorRegion.text.toString(), todosAtributos.nregion);
            }
            Navigator.of(context).pop();
            controladorRegion.clear();
          },
        ),
      ],
    );
  }

  agregarRegion(String nombre, List<String> nregion) async {
    final crearRegion = ParseObject('Region')..set('nombre', nombre);
    var respuesta = await crearRegion.save();
    if (respuesta.success) {
      print("Se creo la región exitosamente.");
    }
      await buscarRegiones(todosAtributos.regiones, todosAtributos.nregion);
      construccionBody.atributos=todosAtributos;
  }

  validarRegion(String nombre, List<String> nombres) {
    variableRegion = true;
    for (int i = 0; i < nombres.length; i++) {
      if (nombre.toLowerCase().compareTo(nombres[i].toLowerCase()) == 0) {
        print('Ya esta');
        variableRegion = false;
      } else {
        print('No esta');
      }
    }
  }
}

crearTipo(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADTipo();
      });
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
      title: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              }),
          Center(
            child: Text('Crear Tipo'),
          )
        ],
      ),
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
          onPressed: () async {
            await validarTipo(
                controladorTipo.text.toString(), todosAtributos.ntipos);
            if (variableTipo == true) {
              agregarTipo(controladorTipo.text.toString(), todosAtributos.ntipos);
            }
            Navigator.of(context).pop();
            controladorTipo.clear();
          },
        ),
      ],
    );
  }

  agregarTipo(String nombre, List<String> ntipos) async {
    final crearTipo = ParseObject('Tipo')..set('nombre', nombre);
    var respuesta = await crearTipo.save();
    if (respuesta.success) {
      print("Se creo el tipo exitosamente.");
    }
    await buscarTipos(todosAtributos.tipos, todosAtributos.ntipos);
  }

  validarTipo(String nombre, List<String> nombres) {
    variableTipo = true;
    for (int i = 0; i < nombres.length; i++) {
      if (nombre.toLowerCase().compareTo(nombres[i].toLowerCase()) == 0) {
        print('Ya esta');
        variableTipo = false;
      } else {
        print('No esta');
      }
    }
  }
}

crearDieta(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADDieta();
      });
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
      title: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              }),
          Center(
            child: Text('Crear Dieta'),
          )
        ],
      ),
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
          onPressed: () async {
            await validarDieta(
                controladorDieta.text.toString(), todosAtributos.ndietas);
            if (variableDieta == true) {
              agregarDieta(controladorDieta.text.toString(), todosAtributos.ndietas);
            }
            Navigator.of(context).pop();
            controladorDieta.clear();
          },
        ),
      ],
    );
  }

  agregarDieta(String nombre, List<String> ndietas) async {
    final crearDieta = ParseObject('Dieta')..set('nombre', nombre);
    var respuesta = await crearDieta.save();
    if (respuesta.success) {
      print("Se creo la dieta exitosamente.");
    }
    await buscarDietas(todosAtributos.dietas, todosAtributos.ndietas);
  }

  validarDieta(String nombre, List<String> nombres) {
    variableDieta = true;
    for (int i = 0; i < nombres.length; i++) {
      if (nombre.toLowerCase().compareTo(nombres[i].toLowerCase()) == 0) {
        print('Ya esta');
        variableDieta = false;
      } else {
        print('No esta');
      }
    }
  }
}

crearUten(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return construcADUten();
      });
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
      title: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                Navigator.pop(context);
              }),
          Center(
            child: Text('Crear Utensilio'),
          )
        ],
      ),
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
          onPressed: () async {
            await validarUtensilio(controladorUtensilio.text.toString(),
                todosAtributos.nutensilios);
            if (variableUtensilio == true) {
              agregarUtensilio(controladorUtensilio.text.toString(),
                  controladorUtenDes.text.toString(), todosAtributos.nutensilios);
            }
            Navigator.of(context).pop();
            controladorUtensilio.clear();
          },
        ),
      ],
    );
  }

  agregarUtensilio(String nombre, String descripcion, List<String> nutensilios) async {
    final crearUtensilio = ParseObject('Utensilio')
      ..set('nombre', nombre)
      ..set('descripcion', descripcion);
    var respuesta = await crearUtensilio.save();
    if (respuesta.success) {
      print("Se creo el utensilio exitosamente.");
    }
    await buscarUtensilios(todosAtributos.utensilios, todosAtributos.nutensilios);
    construccionBody.atributos=todosAtributos;
  }

  validarUtensilio(String nombre, List<String> nombres) {
    variableUtensilio = true;
    for (int i = 0; i < nombres.length; i++) {
      if (nombre.toLowerCase().compareTo(nombres[i].toLowerCase()) == 0) {
        print('Ya esta');
        variableUtensilio = false;
      } else {
        print('No esta');
      }
    }
  }
}

Future<Atributos> buscarInfo(Atributos todosAtributos) async {
  await buscarTipos(todosAtributos.tipos, todosAtributos.ntipos);
  await buscarRegiones(todosAtributos.regiones, todosAtributos.nregion);
  await buscarDietas(todosAtributos.dietas, todosAtributos.ndietas);
  await buscarUtensilios(todosAtributos.utensilios, todosAtributos.nutensilios);
  construccionBody.atributos=todosAtributos;
  return todosAtributos;
}

void buscarTipos(List<Tipo> tipos, List<String> ntipos) async {
  await obtenerTipo(tipos);
  for (int i = 0; i < tipos.length; i++) {
    if (validar(ntipos, tipos[i].nombre) == false) {
      ntipos.add(tipos[i].nombre);
    }
  }
}

void buscarRegiones(List<Region> regiones, List<String> nregion) async {
  await obtenerRegiones(regiones);
  for (int i = 0; i < regiones.length; i++) {
    if (nregion.indexOf(regiones[i].nombre) == -1) {
      nregion.add(regiones[i].nombre);
    }
  }
}

void buscarDietas(List<Dieta> dietas, List<String> ndietas) async {
  await obtenerDietas(dietas);
  for (int i = 0; i < dietas.length; i++) {
    if (validar(ndietas, dietas[i].nombre) == false) {
      ndietas.add(dietas[i].nombre);
    }
  }
}

void buscarUtensilios(
    List<Utensilio> utensilios, List<String> nutensilios) async {
  await obtenerUtensilios(utensilios);
  for (int i = 0; i < utensilios.length; i++) {
    if (validar(nutensilios, utensilios[i].nombre) == false) {
      nutensilios.add(utensilios[i].nombre);
    }
  }
}

bool validar(List<String> listan, String nombre) {
  for (int i = 0; i < listan.length; i++) {
    if (nombre.toString().compareTo(listan[i]) == 0) {
      return true;
    }
  }
  return false;
}

class Atributos {
  Atributos(
        this.dietas,
       this.ndietas,
       this.tipos,
       this.ntipos,
       this.regiones,
       this.nregion,
       this.utensilios,
       this.nutensilios);

  List<Dieta> dietas;
  List<String> ndietas;
  List<Tipo> tipos;
  List<String> ntipos;
  List<Region> regiones;
  List<String> nregion;
  List<Utensilio> utensilios;
  List<String> nutensilios;
}

Dieta buscarDietaNombre(String nombre){
  for (int i = 0; i < todosAtributos.dietas.length; i++){
    if(todosAtributos.dietas[i].nombre.compareTo(nombre) == 0){
      return todosAtributos.dietas[i];
    }
  }
  return null;
}

Tipo buscarTipoNombre(String nombre){
  for (int i = 0; i < todosAtributos.tipos.length; i++){
    if(todosAtributos.tipos[i].nombre.compareTo(nombre) == 0){
      return todosAtributos.tipos[i];
    }
  }
  return null;
}

Region buscarRegionNombre(String nombre){
  for (int i = 0; i < todosAtributos.regiones.length; i++){
    if(todosAtributos.regiones[i].nombre.compareTo(nombre) == 0){
      return todosAtributos.regiones[i];
    }
  }
  return null;
}

Utensilio buscarUtensilioNombre(String nombre){
  for (int i = 0; i < todosAtributos.utensilios.length; i++){
    if(todosAtributos.utensilios[i].nombre.compareTo(nombre) == 0){
      return todosAtributos.utensilios[i];
    }
  }
  return null;
}

void setAtributosR(){
  recetaCreacion.recetac.dieta = buscarDietaNombre(seleccionDieta);
  recetaCreacion.recetac.tipo = buscarTipoNombre(seleccionTipo);
  recetaCreacion.recetac.region = buscarRegionNombre(seleccionRegion);
  recetaCreacion.recetac.utensilios.add(buscarUtensilioNombre(seleccionUtensilio));
  //print("objectID UT ${recetaCreacion.recetac.utensilios[0].objectId}");
  //print("Nombre UT ${recetaCreacion.recetac.utensilios[0].nombre}");
}