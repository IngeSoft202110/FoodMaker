import 'package:flutter/material.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'Page2.dart';
import 'Pantallas/ListaRecetas.dart';

List<Receta> otrasr=List<Receta>();

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
      // Falta mejorar los icons con las imagenes adecuadas
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
      //Botones inferiores fin
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.person_add), title: Text(''),backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.assessment), title: Text(''),backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(''), backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.star), title: Text(''),backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text(''), backgroundColor: Colors.lightGreen),
          ]),

      body : mostrarRecetas(),
    );
  }
}

Widget mostrarRecetas(){
  obtenerRecetas(otrasr);
  return Listadinamica(otrasr);
}
