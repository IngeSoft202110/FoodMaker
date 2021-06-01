import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodmakera/Clases/Paso.dart';
import 'package:foodmakera/Clases/Receta.dart';
 import 'PCRPrincipal.dart';
import 'PantallaFoto.dart';

List<Item> Itempasos = [];

class PCRPasos extends StatefulWidget {
  Receta receta;
  Verificar listaVerificar;
  PCRPasos(this.receta, this.listaVerificar);
  @override
  State<StatefulWidget> createState() => estadoPCRPasos();
}

class estadoPCRPasos extends State<PCRPasos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height - 150,
          width: MediaQuery.of(context).size.width - 5,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Center(child: Text("Pasos Creados", style: TextStyle(fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: listaPasos(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      DialogoCrear(context);
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              )
            ],
          )),
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
                          mostrarFoto.Imagen= await DialogoFoto(context);
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
                    maxLength: 2,//Soporta 99 Pasos
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (controlador.text.length > 0 && controladororden.text.length > 0) {
                          anadirPaso(controlador, controladororden);
                          await crearAviso(
                              context, "Se creo con exito el paso", "Aviso");
                          Navigator.pop(context);
                        } else {
                          crearAviso(context,
                              "Debe escribir la descripcion del paso y su orden", "Error");
                        }
                      },
                      child: Text('Crear Paso'))
                ],
              ),
            );
          });
        });
  }

  ordenarItems(){
    List<Item> Itempasosarreglar =Itempasos;
    for(int i=0; i < Itempasos.length; i++){
      for(int j=0; j <Itempasos.length-1;j++){
        if(Itempasos[j].Ubicacion > Itempasos[j+1].Ubicacion){
          Item aux=Itempasos[j];
          Itempasos[j] =Itempasos[j+1];
          Itempasos[j+1]=aux;
        }
      }
    }
    setState(() {
      Itempasos=Itempasosarreglar;
    });
  }
  anadirPaso(TextEditingController controlador,TextEditingController controladororden){
    Item paso=Item.vacio();
    print("Entro");
    paso = Item(
        controlador,
        controladororden,
        Paso.crear(
            int.parse(controladororden.text.toString()), controlador.text.toString(), "Hola"),
        int.parse(controladororden.text.toString()),
        mostrarFoto.Imagen);
    Itempasos.add(paso);
    ordenarItems();
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
                  child:TextField(
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
                  child:TextField(
                    controller: Itempasos[index].controladorOrden,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.deny(',.-')],
                    maxLength: 2,//Soporta 99 Pasos
                    decoration: InputDecoration(border: OutlineInputBorder()),

                    onEditingComplete:(){
                      
                    }
                      /*
                      if(Itempasos[index].controladorOrden.text.length > 0){
                        Itempasos[index].paso.numero=int.parse(Itempasos[index].controladorOrden.text);
                        //estadoPCRPasos().ordenarItems();
                      }else{
                        Itempasos[index].controladorOrden.text=Itempasos[index].paso.numero.toString();
                      }*/
                    ,
                    onSubmitted: (text){
                      /*if(Itempasos[index].controladorOrden.text.length > 0){
                        Itempasos[index].paso.numero=int.parse(Itempasos[index].controladorOrden.text);
                        //estadoPCRPasos().ordenarItems();
                      }else{
                        Itempasos[index].controladorOrden.text=Itempasos[index].paso.numero.toString();
                      }*/
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
  
  Widget devuelveFoto(Item item){
    if(item.foto != null){
      return Image.file(item.foto);
    }else{
      return Text("");
    }
  }
}

class Item {
  Item(this.controlador, this.controladorOrden,this.paso, this.Ubicacion, this.foto);
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

