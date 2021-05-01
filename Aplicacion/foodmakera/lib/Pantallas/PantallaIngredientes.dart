import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Ingrediente.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:foodmakera/Config/ClienteGraphQL.dart';

import '../Clases/Ingrediente.dart';

//Se guardan los nombres de los ingredientes traidos desde el Query
List<String> nombreIngredientes = List<String>();
List<String> auxCuandoBusca = List<String>();

// Controlador del texto que se escribe en el TextField (Es el que se da cuenta de los cambios en el texto)
TextEditingController controladortext = TextEditingController();
//Se almacenan los ingredientes traidos (Sin uso todavia)
List<Ingrediente> ingredientes = List<Ingrediente>();

// Se construye el showDialog que se devuelve a la clase que lo llamo
PantallaIngredientes(BuildContext context) async {
  //Hace el query para traer todos los ingredientes
  await traerIngredientes();
  return showDialog(
      context: context,
      builder: (context) {
        return construccionAlertDialog();
      });
}

//Se devuelve el AlertDialog
class construccionAlertDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoAlert();
}

//Se crea el AlertDialog con estado para que se actualice cuando los valores cambian
class estadoAlert extends State<construccionAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        titlePadding: EdgeInsets.all(0.0),
        title: barraBusqueda(),
        content: Column(children: <Widget>[IngredientesDinamico()]));
  }

  //Crea la barra de busqueda AppBar
  Widget barraBusqueda() {
    return AppBar(
      automaticallyImplyLeading: false,
      //Boton para limpiar la bisqueda
      leading: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            controladortext.clear();
            buscar(controladortext);
          });
        },
      ),
      //El titulo de la AppBar que esta constituido por un TextField
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5, right: 5),
        child: SizedBox(
            width: 200,
            height: 35,
            child: TextField(
              textAlign: TextAlign.center,
              controller: controladortext,
              //Acciones ejecutadas cuando hay cambios en el texto
              onChanged: (text) {
                controladortext.text = text;
                //Posiciona el cursor en la ultima letra escrita
                controladortext.selection = (TextSelection.fromPosition(
                    TextPosition(offset: text.length)));
                //Actualiza los elementos mostrados con las palabras del TextField
                setState(() {
                  buscar(controladortext);
                });
              },
              //Permite darle el estilo a el TextField
              style: TextStyle(color: Colors.black, fontSize: 18),
              cursorColor: Colors.black,
              autofocus: true,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            )),
      ),
      actions: [
        //Muestra el boton de busqueda para ayudar a el usuario (No tiene ninguna accion)
        IconButton(
          icon: Icon(Icons.search, color: Colors.black),
        )
      ],
    );
  }
}

//Recibe el controlador del Textfield para sacar el texto y poder hacer la busqueda
//y mostrar lo que usuario quiere
buscar(TextEditingController control) {
  //Listado de palabras que considen con la busqueda
  List<String> resultados = List<String>();
  //Palabra escrita en el TextField
  String buscar = control.text.toString().toLowerCase();
  //Guarda una palabra para hacer el recorrido y comparar
  String auxiliar;

  //Si no esta vacio el TextField hace la busqueda
  if (control.text.isNotEmpty) {
    nombreIngredientes.forEach((element) {
      auxiliar = element;
      element = element.toLowerCase();
      if (element.contains(buscar)) {
        resultados.add(auxiliar);
      }
    });
    //Actualiza la lista de palabras para que se muestren en la lista de checkBox
    IngredientesDinamico.listaCrear = resultados;
  } else { //Si esta vacio el TextField mustra todos los ingredientes
    //Actualiza la lista de palabras para que se muestren en la lista de checkBox
    IngredientesDinamico.listaCrear = nombreIngredientes;
  }
}

//devuelve la lista de CheckBox
class IngredientesDinamico extends StatefulWidget {
  static List<String> listaCrear;
  @override
  State<StatefulWidget> createState() => estadoDinamico();
}

//Crea la lista de checbox y permite que se puede actualizar
class estadoDinamico extends State<IngredientesDinamico> {
  @override
  Widget build(BuildContext context) {
    return CheckboxGroup(
      //Coloca solo los nombres de los ingrdientes que se han seteado
      labels: IngredientesDinamico.listaCrear,
      //Se actualiza la lista de seleccionados y con esto tambien
      onSelected: (List auxseleccion) => setState(() {
        //Las dos siguientes lineas permiten que al seleccionar o deseleccionar
        //Liempie la busqeda y vuelva a mostrar todos los ingredientes
        controladortext.clear();
        buscar(controladortext);
        auxseleccion = auxseleccion;
      }),
    );
  }
}

//Hace el Query en la base de datos
void traerIngredientes() async {
  List<Ingrediente> ingre=List<Ingrediente>();
  List<String> nombres=List<String>();
 await obtenerIngredientes(ingredientes);
    for(int i=0; i < ingredientes.length; i++) {
      nombres.add(ingredientes[i].nombre);
    }
    //Hace set al nombre de todos los ingredientes en la variable global
    nombreIngredientes = nombres;
    //Hace set a los nombres de los ingredientes para que se muestren en la primera vez
    // y no este vacio
    IngredientesDinamico.listaCrear = nombres;
  }

