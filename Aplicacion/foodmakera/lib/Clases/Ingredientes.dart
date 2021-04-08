import 'package:flutter/material.dart';

class Ingredientes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return crearVentanaDialogo(context);
  }

  crearVentanaDialogo(BuildContext context){
    return showDialog(context: context,
      builder: (context){
       return AlertDialog(
         scrollable: true,
         titlePadding: EdgeInsets.all(0.0),
         title: AppBar(
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed:(){

              })
            ],
         ),
       );
      }

    );
  }
}

