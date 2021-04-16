
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:hexcolor/hexcolor.dart';
import 'MostrarRecera.dart';



class Listadinamica extends StatefulWidget { //Crear el estado de la lista de recetas
  List<Receta> recetas=List<Receta>();
  Listadinamica(this.recetas);
  @override
  State<StatefulWidget> createState() => estadoCartas();
}

class estadoCartas extends State<Listadinamica> {
    @override
  Widget build(BuildContext context) {
      int valor=widget.recetas.length;
      print("recetas de aqui: $valor");
    return ListView.builder(
        itemCount: widget.recetas.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 180,
              child:InkWell(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => mostarRecera(widget.recetas[index])));
                },
            child: Card(
              color: HexColor("#CCFFB8"),
              elevation: 60, 
                clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.all(7),
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: <Widget>
                  [
                    SizedBox(
                      height: 1,
                      width: 1,
                    )
                    ,
                    Center(child: Text(widget.recetas[index].Nombre)),
                    Divider(height: 12,indent: 1,endIndent: 1,color: Colors.black,),
                    Row(//Imagen y todo lo de al lado
                      children: [
                        SizedBox(
                          width: 170,
                          height: 100,
                          child: Image.network(widget.recetas[index].url, fit: BoxFit.cover,),
                        ),
                        Column(
                          children:<Widget> [
                            Container(
                              width: 150,
                              padding: EdgeInsets.all(5),
                              child: Text(widget.recetas[index].descripcion,style: TextStyle(fontSize: 9),textAlign: TextAlign.justify,
                              softWrap: true,),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(widget.recetas[index].tiempo.toString(),style: TextStyle(fontSize: 10),textAlign: TextAlign.left,),
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
