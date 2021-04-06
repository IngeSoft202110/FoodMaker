import 'package:flutter/material.dart';

class TipoDeComida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicacion
      appBar: AppBar(
        title: Text(
          'Seleccione su tipo de comida preferido', textAlign: TextAlign.center,),
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