import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodmakera/Clases/Paso.dart';
import 'package:image_picker/image_picker.dart';


List<Item> Itempasos=[];

class PCRPasos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: MediaQuery.of(context).size.width-150,
       width: MediaQuery.of(context).size.width-30,
       child:listaPasos() ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Item paso;
           DialogoCrear(context,paso);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class listaPasos extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => estadoPasos();
}

class estadoPasos extends State<listaPasos>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Itempasos.length,
      itemBuilder: (context, index){
        return Card(
          elevation: 15,
          child:
          Container(
            width: MediaQuery.of(context).size.width-35,
            height: 50,
            child: Column(
              children:<Widget> [
                //Fotografia
                Container(

                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Descripcion'),
                ),
                TextField(
                  controller: Itempasos[index].controlador,
                  maxLines: null,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
              ],
            ),
          )
          ,
        );
      },
    );
  }
}

class Item {
  Item(this.controlador, this.paso, this.Ubicacion);

TextEditingController controlador;
Paso paso;
int Ubicacion;

}


  DialogoCrear(BuildContext context, Item paso) async {
    return showDialog(
        context: context,
        builder: (context) {
          int numero = 1;
          TextEditingController controlador = TextEditingController();
          return AlertDialog(
            title: Text('Crear Paso'),
            content: Column(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 100,
                  child: imagenDinamica(),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await galeriaFoto(context);
                    },
                    child: Text('Cargar Fotografia')),
                TextField(
                  controller: controlador,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (controlador.text.length > 0) {
                        paso = Item(controlador, Paso.crear(
                            numero, controlador.text.toString(), "Hola"),
                            numero);
                      }
                    },
                    child: Text('Crear Paso'))
              ],
            ),
          );
        });
  }


  galeriaFoto(BuildContext context) async{
    imagenDinamica.foto=await ImagePicker.pickImage(source: ImageSource.gallery);
  }


  class imagenDinamica extends StatefulWidget{
  @override
  static var foto;
  State<StatefulWidget> createState() =>estadoImagen();
  }


  class estadoImagen extends State<imagenDinamica>{
  @override
  Widget build(BuildContext context) {
    if(imagenDinamica.foto != null){
      return  Image.file(imagenDinamica.foto,width: 40,height: 100);
    }else{
      return Center(child: Text("Seleccione una imagen"),);
    }
  }
  }





crearAviso(BuildContext context, String info) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informacion'),
          content: Center(child: Text(info),),
        );
      }
  );
}



