import 'package:flutter/material.dart';
import 'package:foodmakera/PHome.dart';
import 'package:foodmakera/PRegistrarUsuarioNuevo.dart';
import 'package:foodmakera/PRegistro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'PChat.dart';
import 'PReporte.dart';
import 'Pantallas/ListaRecetas.dart';
import 'PPerfil.dart';

List<Receta> otrasr = List<Receta>();

class PPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoPPrincipal();
}

class EstadoPPrincipal extends State<PPrincipal> {
  @override
  String ussername = '';

  Future GetUssername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ussername = await preferences.getString(('ussername'));
  }

  @override
  void initState() {
    super.initState();
    GetUssername();
  }
  //Aca se enlistan las pantallas las cuales corresponden a los botones inferiores
  int _currentIndex = 0;
  final List <Widget> _children = [
    PHome(),
    PPerfil(),
    PPerfil(),
    PPerfil(),
    PPerfil(),
  ];
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
      body: _children[_currentIndex],
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
            leading: Icon(Icons.chat),
            title: Text('Chats'),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => PChat()));
            },
          ),
          ListTile(
            leading: Icon(Icons.toc_outlined),
            title: Text('Configuracion'),
          )
        ],
      )),
      //Botones inferiores fin
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                title: Text('Mas vistas'),
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                title: Text('Seguidos'),
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Favoritas'),
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Mi perfil'),
                backgroundColor: Colors.lightGreen),
          ]),
    );
  }
//Funcion para cambiar el index de cada boton inferior
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

Future<List<Receta>> llenarRecetas() async {
  List<Receta> todas = List<Receta>();
  await obtenerRecetas(todas);
  return todas;
}
