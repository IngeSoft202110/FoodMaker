import 'package:flutter/material.dart';
import 'package:foodmakera/PRegistrarUsuarioNuevo.dart';
import 'package:foodmakera/PRegistro.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'PReporte.dart';
import 'Pantallas/ListaRecetas.dart';

List<Receta> otrasr = List<Receta>();

class PPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoPPrincipal();
}

class EstadoPPrincipal extends State<PPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicacion
      appBar: AppBar(
        title: Center(
          child: Text(
            'Food Maker',
            textAlign: TextAlign.center,
          ),
        ),
        //Boton de Busqueda
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => PBuscarRecetas()));
              })
        ],
      ),
      // Menu lateral
      // Iconos menu lateral izquierdo
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.lightGreen),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Iniciar Sesion'),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => PRegistro()));
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Registrate'),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => PRegistrarUsuarioNuevo()));
            },
          ),
          ListTile(
            leading: Icon(Icons.archive_outlined),
            title: Text('Crear receta'),
          ),
          ListTile(
            leading: Icon(Icons.report_problem),
            title: Text('Crear reporte'),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => PReporte()));
            },
          ),
          ListTile(
            leading: Icon(Icons.toc_outlined),
            title: Text('Configuracion'),
          )
        ],
      )),
      //Botones inferiores fin
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            title: Text(''),
            backgroundColor: Colors.lightGreen),
        BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text(''),
            backgroundColor: Colors.lightGreen),
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
            backgroundColor: Colors.lightGreen),
        BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text(''),
            backgroundColor: Colors.lightGreen),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(''),
            backgroundColor: Colors.lightGreen),
      ]),

      body: FutureBuilder(
        future: llenarRecetas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.hasError.toString()}'));
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            otrasr = snapshot.data;
            return Listadinamica(otrasr);
          }
        },
      ),
    );
  }
}

Future<List<Receta>> llenarRecetas() async {
  List<Receta> todas = List<Receta>();
  await obtenerRecetas(todas);
  return todas;
}
