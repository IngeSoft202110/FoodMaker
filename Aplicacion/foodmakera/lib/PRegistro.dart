import 'package:flutter/material.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'Pantallas/ListaRecetas.dart';
import 'Config/ClienteGraphQL.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class PRegistro extends StatefulWidget{

  final String title;

  PRegistro({Key key, this.title}): super (key: key);
  _PRegistroState createState() => _PRegistroState();
}



class _PRegistroState extends State <PRegistro>
{

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold
      (
        appBar: AppBar(
        title: Text(
        'Registro',
        textAlign: TextAlign.center,
    ),
    //Boton de Busqued
    ),
    body: Container(
    padding: EdgeInsets.all(15.0),
    child: Column(
    mainAxisAlignment:  MainAxisAlignment.center,
    children: <Widget>[
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
         labelText: 'Correo Electronico',
         icon: Icon(Icons.email)
         ) ,
        ),
      SizedBox(height:15.0 ,),
      TextField(
        controller: _passwordController,
        decoration: InputDecoration(
            labelText: 'Contraseña',
            icon: Icon(Icons.vpn_key_outlined)
        ) ,
      ),
      SizedBox(height:15.0 ,),
      FlatButton(
        child:Text('Iniciar Sesión'),
        color: Colors.lightGreen,
        textColor: Colors.black,
        onPressed: (){

        },
      )
       ],
      )
     ),
    );
  }
}
