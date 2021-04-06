import 'package:flutter/material.dart';
import 'Page2.dart';
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicacion
      appBar: AppBar(
        title: Center(
          child: Text(
            'Food Maker', textAlign: TextAlign.center,),
        ),
    //Boton de Busqueda
    actions: <Widget>[
    IconButton(icon: Icon(Icons.search), onPressed:()
    {
      Navigator.push(context, new MaterialPageRoute(builder: (context) => Page2()));
    })
                    ],
    ),
      // Menu lateral
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.lightGreen
                ),
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Iniciar Sesion'),
              ),
              ListTile(
                leading: Icon(Icons.archive_outlined),
                title: Text('Crear receta'),
              ),
              ListTile(
                leading: Icon(Icons.toc_outlined),
                title: Text('Configuracion'),
              )
            ],
          )
      ),
      //Botones inferiores
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text(''), backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(''), backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.star), title: Text(''),backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.assessment), title: Text(''),backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.person_add), title: Text(''),backgroundColor: Colors.lightGreen),
          ]),

      body : Container(
        child: Center(
          child: Text(
            'Elementos de base de datos, agregar imagenes con el asset por base de datos NO OLVIDAR',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

  }
}
