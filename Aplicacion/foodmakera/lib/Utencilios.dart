import 'package:flutter/material.dart';

class Utencilios extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicacion
      appBar: AppBar(
        title: Text(
          'Seleccione sus Utencilios', textAlign: TextAlign.center,),
        //Boton de Busqueda
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed:()
          {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}