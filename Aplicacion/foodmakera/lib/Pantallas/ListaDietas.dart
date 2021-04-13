
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'MostrarRecera.dart';

List<String> Nombres = [
  'Perro',
  'Albomdiga',
  'Mango',
  'Gato',
  'Nueva',
  'Palabra',
  'Cosa',
  'Java',
  'HTML;'
];

List<String> url=[
  "assets/papasFrancesa.jpg","assets/receta1.jpg","assets/receta2.jpg","assets/receta3.jpg",
  "assets/papasFrancesa.jpg","assets/receta1.jpg","assets/receta2.jpg","assets/receta3.jpg",
  "assets/papasFrancesa.jpg"];

class Listadinamica extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoCartas();
}

class estadoCartas extends State<Listadinamica> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Nombres.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 180,
              child:InkWell(
                onTap: (){
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => mostarRecera()));
                },
            child: Card(
              color: HexColor("#FFFFFF"),
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
                    Center(child: Text(Nombres[index])),
                    Divider(height: 12,indent: 1,endIndent: 1,color: Colors.black,),
                    Row(//Imagen y todo lo de al lado
                      children: [
                        SizedBox(
                          width: 170,
                          height: 100,
                          child: Image.asset(url[index], fit: BoxFit.cover,),
                        ),
                        Column(
                          children:<Widget> [
                            Container(
                              width: 150,
                              padding: EdgeInsets.all(5),
                              child: Text("Receta hecha con amor y con todo el "
                                  "Apoyo del mundo por que soy el mejor",style: TextStyle(fontSize: 12),textAlign: TextAlign.justify,
                              softWrap: true,),

                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              child: Text("Duracion: 10 minutos",style: TextStyle(fontSize: 12),textAlign: TextAlign.left,),
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
