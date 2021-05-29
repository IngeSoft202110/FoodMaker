import 'package:flutter/material.dart';
import 'PCambioNombre.dart';
import 'PCambioContrasena.dart';
import 'PEliminar.dart';

class PAjustes extends StatefulWidget {
  final String title;
  PAjustes({Key key, this.title}) : super(key: key);
  _PAjustesState createState() => _PAjustesState();
}

String ussername = '';

class _PAjustesState extends State<PAjustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Ajustes',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 30, width: 100, child: Text(ussername)),
          SizedBox(
              height: 115,
              width: 115,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/perfil1.jpeg"),
              )),
          //FotoPerfil();
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => PCambioNombre()));
                  },
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.lightGreen,
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 22,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Text("Cambiar Nombre de usuario")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => PCambioContrasena()));
                  },
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.lightGreen,
                  child: Row(
                    children: [
                      Icon(
                        Icons.vpn_key,
                        size: 22,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Text("Cambiar Contraseña")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ))),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => PEliminar()));
                  },
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.lightGreen,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 22,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(child: Text("Eliminar perfil")),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ))),
        ],
      ),
    );

  }
}
