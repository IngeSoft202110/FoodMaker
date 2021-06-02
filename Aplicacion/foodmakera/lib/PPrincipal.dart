import 'package:flutter/material.dart';
import 'package:foodmakera/Chat/Chat.dart';
import 'package:foodmakera/Config/StringConsultas.dart';
import 'package:foodmakera/PHome.dart';
import 'package:foodmakera/PRegistrarUsuarioNuevo.dart';
import 'package:foodmakera/PRegistro.dart';
import 'package:foodmakera/PantallasCrearReceta/PCRPrincipal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Clases/Receta.dart';
import 'Config/convertirQuery.dart';
import 'PBuscarRecetas.dart';
import 'PChat.dart';
import 'PPerfil.dart';
import 'PReporte.dart';
import 'PPerfil.dart';

List<Receta> otrasr = [];

class PPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EstadoPPrincipal();
}

class EstadoPPrincipal extends State<PPrincipal> {
  @override

  Future GetUssername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    ussername = await preferences.getString(('ussername'));
  }

  @override
  void initState() {
    super.initState();
    GetUssername();
    print(ussername);
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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo.PNG')
              ),
                color: Colors.lightGreen),
            child:SizedBox(),
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Iniciar Sesión'),
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
            onTap: (){
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => PCRPrincipal()));
            },
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
              if(ussername=="Nico")
              {print("entro nico");
                Navigator.push(context,new MaterialPageRoute(builder: (context) => PChat()));
              }
              if(ussername=="JoseReus"){
                print("entro jose");
                Navigator.push(context,new MaterialPageRoute(builder: (context) => Chat()));
              }

            },
          ),
        ],
      )),
      //Botones inferiores fin
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                label: 'Mas vistas',
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add),
                label: 'Seguidos',
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: 'Favoritas',
                backgroundColor: Colors.lightGreen),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Mi perfil',
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
  List<Receta> todas = [];
  await obtenerRecetas(todas, Consultas().buscartodasRecetas);
  return todas;
}

