import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          textAlign: TextAlign.center,
        ),
        //Boton de Busqueda
        actions: <Widget>[
          //Necesitamos la base de datos
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}