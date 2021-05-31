import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:hexcolor/hexcolor.dart';
import 'MostrarRecera.dart';


class Listadinamica extends StatefulWidget {
  //Crear el estado de la lista de recetas
  List<Receta> recetas = [];
  Listadinamica(this.recetas);
  @override
  State<StatefulWidget> createState() => estadoCartas();
}

class estadoCartas extends State<Listadinamica> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.recetas.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 180,
            //Hace que la card sea clicleable
            child: InkWell(
                //Muestra la receta si se cliquea
                onTap: () async {
                  widget.recetas[index] =await  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              mostarRecera(widget.recetas[index])));
                },
                //Crear cada carta
                child: Card(
                    //Color del fondo de la carta
                    color: HexColor("#CCFFB8"),
                    elevation: 60,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.all(7),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: <Widget>[
                        //Espacio al inicio de la carta
                        SizedBox(
                          height: 1,
                          width: 1,
                        ),
                        //Linea divisoria en la carta
                        Center(child: Text(widget.recetas[index].Nombre)),
                        Divider(
                          height: 12,
                          indent: 1,
                          endIndent: 1,
                          color: Colors.black,
                        ),
                        //Aqui se coloca la imagen y todo lo demas
                        Row(

                          children: [
                            //Se coloca la imagen
                            SizedBox(
                              width: 170,
                              height: 100,
                              child: Image.network(
                                widget.recetas[index].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              //Se coloca la descripcion
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    widget.recetas[index].descripcion,
                                    style: TextStyle(fontSize: 9),
                                    textAlign: TextAlign.justify,
                                    softWrap: true,
                                  ),
                                ),
                                //se coloca el tiempo que demora cada receta
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(children: <Widget>[
                                    Text(
                                      'Tiempo: ',
                                      style: TextStyle(fontSize: 10),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      widget.recetas[index].tiempo.toString(),
                                      style: TextStyle(fontSize: 10),
                                      textAlign: TextAlign.left,
                                    ),
                                  ]),
                                )
                              ],
                            )
                          ],
                        ),
                      ]),
                    ))),
          );
        });
  }
}
