import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';

class mostarRecera extends StatelessWidget {
  Receta receta;
  mostarRecera(this.receta);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Receta')),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: SizedBox(
                 height: 150,
                 width: 400,
                 child: Image.network(receta.url, fit: BoxFit.cover,),
                ),
              ),
              Center(child: Text(receta.Nombre, textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),),
              Text('Subido por: FoodMaker', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text('Ingredientes:', textAlign: TextAlign.left, style: TextStyle(fontSize: 12),),
              //Ingredientes -> base
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text('Descripción:', textAlign: TextAlign.left, style: TextStyle(fontSize: 12),),
              Text('${receta.descripcion} ', textAlign: TextAlign.left, style: TextStyle(fontSize: 12),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text('Instrucciones: ', textAlign: TextAlign.left, style: TextStyle(fontSize: 12),),
              Text('${receta.pasos} ', textAlign: TextAlign.left, style: TextStyle(fontSize: 12),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text(' ', textAlign: TextAlign.left, style: TextStyle(fontSize: 8),),
              Text('Comentarios: ', textAlign: TextAlign.left, style: TextStyle(fontSize: 12),),

            ],
          )
      )
    );
  }
}
