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
          Center(child: Text(receta.Nombre)),

        ],
      )),
    );
  }
}
