import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Receta.dart';
import 'package:foodmakera/Clases/User.dart';
import 'package:foodmakera/Config/QueryConversion.dart';
import 'package:foodmakera/Config/convertirQuery.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

Receta recetat;
bool pguardar = false;
bool pmegusta = false;
double posicion;
List<Container> listaContenedores;
User usuario;
final double anchopasos = 360;
TextStyle titulos = TextStyle(
    fontWeight: FontWeight.bold, fontSize: 15, fontStyle: FontStyle.italic);
TextStyle info = TextStyle(
  fontSize: 12,
);

traerUsuario() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String username = await preferences.getString('ussername');
  List<User> activo = [];
  await obtenerUsuario(username, activo);
  if (activo != null && activo.length > 0) {
    usuario = activo[0];
    print("Encontro Usuario");
  } else {
    print("No encontro usuario");
    usuario = null;
  }
  if (usuario != null) {
    if (usuario.guardades.indexOf(recetat) == -1) {
        print("Esta la receta");
        guardarDinamico().color = Colors.green;
        pguardar = true;
    } else {
        guardarDinamico().color = Colors.black54;
        pguardar = false;
        print("No esta la receta");
    }
  }
}


class mostarRecera extends StatefulWidget {
  Receta receta;
  mostarRecera(this.receta);
  @override
  State<StatefulWidget> createState() => estadoReceta();
}

class estadoReceta extends State<mostarRecera> {
  @override
  Widget build(BuildContext context) {
    recetat = widget.receta;
    traerUsuario();
    megustaDinamico().color = Colors.green;
    AumentarContador();
    return Scaffold(
        appBar: AppBar(
          title: Text('Receta'),
        ),
        backgroundColor: HexColor("#E9F6F6"),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 150,
                width: 420,
                child: Image.network(
                  widget.receta.url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 40,
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Icon(
                        Icons.visibility,
                        color: Colors.blue,
                        size: 18,
                      )),
                  Center(
                      child: Text(
                    recetat.visitas.toString(),
                    style: TextStyle(fontSize: 15),
                  )),
                  guardarDinamico(),
                  megustaDinamico(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  widget.receta.Nombre,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Container(
                height: 15,
                width: 420,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Subido por: ${widget.receta.usuario.username}',
                      textAlign: TextAlign.left, style: info),
                )),
            Text(
              'Ingredientes:',
              textAlign: TextAlign.left,
              style: titulos,
            ),
            Container(
              width: 420,
              height: (recetat.ingredientes.length * 20).toDouble(),
              child: ingredientesDinamicos(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Descripción:',
              textAlign: TextAlign.left,
              style: titulos,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.all(10),
                width: 420,
                child: Text(
                  '${widget.receta.descripcion} ',
                  textAlign: TextAlign.justify,
                  style: info,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              'Instrucciones: ',
              textAlign: TextAlign.left,
              style: titulos,
            ),
            Container(
                /*decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black38
                )
              ),*/
                width: anchopasos,
                height: 430,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: anchopasos,
                      height: 430,
                      child: pasosDinamicos(),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        heroTag: "btn1",
                        onPressed:(){},// avanzar(),
                        mini: true,
                        child: const Icon(Icons.chevron_right),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton(
                          mini: true,
                          heroTag: "btn2",
                          onPressed: (){},//retroceder(),
                          child: const Icon(Icons.chevron_left),
                          backgroundColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        )),
                  ],
                )),
            Text(
              ' ',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 8),
            ),
            Text(
              ' ',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 8),
            ),
            Text(
              'Comentarios: ',
              textAlign: TextAlign.left,
              style: titulos,
            ),
            Container(
              height: (recetat.comentarios.length * 20).toDouble() + 100.0,
              width: 420,
              child: Stack(
                children: <Widget>[
                  comentariosDinamicos(),
                  Container(
                    width: 420,
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      onPressed: () {},
                      mini: true,
                      child: Icon(Icons.add_circle_outline,
                          color: HexColor('#03FEED')),
                      backgroundColor: Colors.transparent,
                    ),
                  )
                ],
              ),
            )
          ],
        )));
  }

  bool buscarRecetaUsuario(String id) {
    for (int i = 0; i < usuario.guardades.length; i++) {
      print("1: ${id}     2: ${usuario.guardades[i].objectId}");
      if (usuario.guardades[i].objectId.compareTo(id) == 0) {
        return true;
      }
    }
    return false;
  }
  /*avanzar() {
    setState(() {
      if (estadoPasos().controlador.hasClients != null) {
        estadoPasos().controlador.animateTo(estadoPasos().controlador.offset + anchopasos,
         duration: Duration(seconds: 1), curve: Curves.linear);
      }
    });
  }

  retroceder() {
    setState(() {
      if (estadoPasos().controlador.hasClients != null) {
        estadoPasos().controlador.animateTo(estadoPasos().controlador.offset + anchopasos,
            duration: Duration(seconds: 1), curve: Curves.linear);
      }
    });
  }*/
}

class guardarDinamico extends StatefulWidget {
  Color color;
  @override
  State<StatefulWidget> createState() => estadoGuardar();
}

class estadoGuardar extends State<guardarDinamico> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.playlist_add_rounded,
        size: 18,
      ),
      color: widget.color,
      onPressed: () {
        setState(() async {
          if (usuario != null) {
            Receta aux = Receta.usuario(recetat.objectId);
            pguardar = !pguardar;
            if (pguardar) {
              if (usuario.guardades.indexOf(aux) == -1) {
                print("Agregar");
                usuario.guardades.add(aux);
                widget.color = Colors.green;
              }
            } else {
              if (usuario.guardades.indexOf(aux) != -1) {
                usuario.guardades.remove(aux);
              }
              widget.color = Colors.black54;
            }
            ParseUser user = await ParseUser.currentUser() as ParseUser;
            user.addRelation(
                "Guardadas",
                usuario.guardades
                    .map((e) => ParseObject('Receta')..objectId = e.objectId)
                    .toList());
            ParseResponse response = await user.save();
            if (response.success) {
              print("ok");
            }
          }
        });
      },
    );
  }
}

class megustaDinamico extends StatefulWidget {
  Color color;
  @override
  State<StatefulWidget> createState() => estadoMeGusta();
}

class estadoMeGusta extends State<megustaDinamico> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        size: 18,
      ),
      color: widget.color,
      onPressed: () {
        setState(() {
          pmegusta = !pmegusta;
          pmegusta ? widget.color = Colors.red : widget.color = Colors.black54;
        });
      },
    );
  }
}

class pasosDinamicos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoPasos();
}

class estadoPasos extends State<pasosDinamicos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: recetat.pasos.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            height: 380,
            width: anchopasos - 5,
            child: Card(
                color: HexColor("#B9F990"),
                margin: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: anchopasos,
                        height: 260,
                        child: Image.network(
                          recetat.pasos[index].fotourl,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                                child: Text("Sin imagen para mostar"));
                          },
                        )),
                    Divider(
                        height: 12,
                        indent: 1,
                        endIndent: 1,
                        color: Colors.black45),
                    Container(
                      color: HexColor("#B9F990"),
                      width: anchopasos,
                      height: 130,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${recetat.pasos[index].numero.toString()}. ${recetat.pasos[index].especificacion}",
                        textAlign: TextAlign.justify,
                        softWrap: true,
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}

class ingredientesDinamicos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoIngrediente();
}

class estadoIngrediente extends State<ingredientesDinamicos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: recetat.ingredientes.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 15,
            child: Text(
              "${recetat.ingredientes[index].nombre}.  cantidad: ${recetat.ingredientes[index].medida}",
              style: info,
            ),
          );
        });
  }
}

class comentariosDinamicos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => estadoComentario();
}

class estadoComentario extends State<comentariosDinamicos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: recetat.comentarios.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 12,
            margin: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "@${recetat.comentarios[index].hizoComentario.username}",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Text(recetat.comentarios[index].descripcion,
                    textAlign: TextAlign.justify, style: info),
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.thumb_up,
                          size: 16,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                          Icons.thumb_down,
                          size: 16,
                        ),
                        onPressed: () {})
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Like",
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Disike",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

AumentarContador() async {
  List<int> nvisitasa = [];
  await obtenerReceta(nvisitasa, recetat.objectId);
  if (nvisitasa != -1) {
    print("Llego de asi: ${nvisitasa}");
    nvisitasa[0] = nvisitasa[0] + 1;
    print("Quedo asi en la DB: ${nvisitasa}");
    var Recta = ParseObject('Receta')
      ..objectId = recetat.objectId
      ..set("vistas", nvisitasa[0]);
    var respuesta = await Recta.save();
    if (respuesta.success) {
      recetat.visitas = nvisitasa[0];
    } else {
      print("No sumo");
    }
  }
}
