import 'package:flutter/material.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'Pantallas/ListaRecetas.dart';


class PRegistro extends StatefulWidget{

  final String title;

  PRegistro({Key key, this.title}): super (key: key);
  _PRegistroState createState() => _PRegistroState();
}
class _PRegistroState extends State <PRegistro>
{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: Text(
        'Registro',
        textAlign: TextAlign.center,
    ),
    //Boton de Busqued
    ),
    );
  }


}
