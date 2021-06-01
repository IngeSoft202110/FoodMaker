import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodmakera/Clases/Paso.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/RecetaCreacion.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'PCRPrincipal.dart';
import 'PantallaFoto.dart';

List<Item> Itempasos = [];
User usuario;

traerUsuario() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = await preferences.getString('ussername');
  List<User> activo = [];
  await obtenerUsuario(username, activo);
  if (activo != null && activo.length > 0) {
    usuario = activo[0];
    print("Encontro Usuario");
  } else {
    print("No encontro usuario");
    usuario = null;
  }
}

class PCRPasos extends StatefulWidget {
  Verificar listaVerificar;
  PCRPasos(this.listaVerificar);
  @override
  State<StatefulWidget> createState() => estadoPCRPasos();
}

class estadoPCRPasos extends State<PCRPasos> {
  @override
  Widget build(BuildContext context) {
    traerUsuario();
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height - 150,
          width: MediaQuery.of(context).size.width - 5,
          child:
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: listaPasos(),
              ),

              /*Align(
                alignment: Alignment.topCenter,
                child: Center(child: Text("Pasos Creados", style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)),
              )*/

              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    setState(() {
                      DialogoCrear(context);
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              onPressed: () {
                  crearRecetaBD();
              },
              label: Text("Crear Receta"),
            ),
          )]),
    ),
    );
  }

  DialogoCrear(BuildContext context) {
    mostrarFoto.Imagen = null;
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController controlador = TextEditingController();
          TextEditingController controladororden = TextEditingController();
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: Center(child: Text('Crear Paso')),
              content: Column(
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 160,
                    child: mostrarFoto(),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() async {
                          mostrarFoto.Imagen = await DialogoFoto(context);
                        });
                      },
                      child: Text('Configurar Fotografia')),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Describa el paso'),
                  ),
                  TextField(
                    controller: controlador,
                    maxLines: null,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Escriba el numero del Paso'),
                  ),
                  TextField(
                    controller: controladororden,
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.deny('.,-')],
                    maxLength: 2, //Soporta 99 Pasos
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (controlador.text.length > 0 &&
                            controladororden.text.length > 0) {
                          anadirPaso(controlador, controladororden);
                          await crearAviso(
                              context, "Se creo con exito el paso", "Aviso");
                          Navigator.pop(context);
                        } else {
                          crearAviso(
                              context,
                              "Debe escribir la descripcion del paso y su orden",
                              "Error");
                        }
                      },
                      child: Text('Crear Paso'))
                ],
              ),
            );
          });
        });
  }

  ordenarItems() {
    List<Item> Itempasosarreglar = Itempasos;
    for (int i = 0; i < Itempasos.length; i++) {
      for (int j = 0; j < Itempasos.length - 1; j++) {
        if (Itempasos[j].Ubicacion > Itempasos[j + 1].Ubicacion) {
          Item aux = Itempasos[j];
          Itempasos[j] = Itempasos[j + 1];
          Itempasos[j + 1] = aux;
        }
      }
    }
    setState(() {
      Itempasos = Itempasosarreglar;
    });
  }

  anadirPaso(TextEditingController controlador,
      TextEditingController controladororden) {
    Item paso = Item.vacio();
    print("Entro");
    paso = Item(
        controlador,
        controladororden,
        Paso.crearDB("", int.parse(controladororden.text.toString()),
            controlador.text.toString(), mostrarFoto.Imagen),
        int.parse(controladororden.text.toString()),
        mostrarFoto.Imagen);
    Itempasos.add(paso);
    ordenarItems();
  }

  crearRecetaBD() async{
    if (comprobar() && Itempasos.length > 0) {
      List<String> pasosOID=[];
      for(int i=0; i < recetaCreacion.recetac.pasos.length; i++){
        final crearPasos = ParseObject('Pasos')
          ..set('numero',recetaCreacion.recetac.pasos[i].numero)
          ..set('especificacion',recetaCreacion.recetac.pasos[i].especificacion)
          ..set('foto',recetaCreacion.recetac.pasos[i].foto);
        var result=await crearPasos.save();
        if (result.success) {
          String objid = result.results.toString().substring(39, 49);
          pasosOID.add(objid);
        }
      }

      final Recetax= ParseObject('Receta')
      ..set('foto', recetaCreacion.recetac.foto)
      ..set('tieneDieta', ParseObject('Dieta')..objectId=recetaCreacion.recetac.dieta.objectId)
      ..addRelation('Pasos', pasosOID.map((e) => ParseObject('Pasos')..objectId = e).toList())
      ..addRelation('tieneIngredientes',recetaCreacion.recetac.ingredientes.map((e) => ParseObject('Ingrediente')..objectId=e.objectId).toList())
      ..addRelation('tieneUtensilios', recetaCreacion.recetac.utensilios.map((e) => ParseObject('Utensilio')..objectId=e.objectId).toList())
      ..set('id_receta',20)
      ..set('vistas',0)
      ..set('Nombre',recetaCreacion.recetac.Nombre)
      ..set('descripcion',recetaCreacion.recetac.descripcion)
      ..set('tieneRegion', ParseObject('Region')..objectId=recetaCreacion.recetac.region.objectId)
      ..set('tieneTipo', ParseObject('Tipo')..objectId=recetaCreacion.recetac.tipo.objectId)
      ..set('creador',ParseObject('User')..objectId=usuario.objectId);
      var result= await Recetax.save();
      if(result.success){
        print('creo la receta');
      }else{
        print('No la creo');
      }


      print("Se puede crear");
    } else {
      print("No se puede crear");
    }
  }

  bool comprobar() {
    for (int i = 0; i < Itempasos.length; i++) {
      if (Itempasos[i].controlador.text.isEmpty ||
          Itempasos[i].controladorOrden.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

}

class mostrarFoto extends StatefulWidget {
  @override
  static var Imagen;
  State<StatefulWidget> createState() => estadomostarFoto();
}

class estadomostarFoto extends State<mostrarFoto> {
  @override
  Widget build(BuildContext context) {
    if (mostrarFoto.Imagen != null) {
      return Image.file(mostrarFoto.Imagen);
    } else {
      return Center(
        child: Text("Sin imagen"),
      );
    }
  }
}

class listaPasos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoPasos();
}

class estadoPasos extends State<listaPasos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Itempasos.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 15,
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width - 35,
            height: 350,
            child: Column(
              children: <Widget>[
                Container(
                  height: 120,
                  width: 180,
                  child: devuelveFoto(Itempasos[index]),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Descripcion'),
                ),
                Container(
                  height: 120,
                  child: TextField(
                    controller: Itempasos[index].controlador,
                    style: TextStyle(fontSize: 12),
                    maxLines: null,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Numero del paso'),
                ),
                Container(
                  height: 50,
                  child: TextField(
                    controller: Itempasos[index].controladorOrden,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.deny(',.-')],
                    maxLength: 2, //Soporta 99 Pasos
                    decoration: InputDecoration(border: OutlineInputBorder()),

                    onEditingComplete: () {
                      Itempasos[index].paso.numero =
                          int.parse(Itempasos[index].controladorOrden.text);
                    },
                    onSubmitted: (text) {
                      Itempasos[index].paso.numero =
                          int.parse(Itempasos[index].controladorOrden.text);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget devuelveFoto(Item item) {
    if (item.foto != null) {
      return Image.file(item.foto);
    } else {
      return Text("");
    }
  }
}

class Item {
  Item(this.controlador, this.controladorOrden, this.paso, this.Ubicacion,
      this.foto);
  Item.vacio();
  TextEditingController controlador;
  TextEditingController controladorOrden;
  Paso paso;
  int Ubicacion;
  var foto;
}

crearAviso(BuildContext context, String info, String titulo) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
          title: Text(titulo),
          content: Center(
            child: Text(info),
          ),
        );
      });
}
