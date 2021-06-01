import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

var Imagen=null;

DialogoFoto(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title:Column(
            children:<Widget> [
              IconButton(
                  onPressed:(){
                    print("La imagen es $Imagen");
                    Navigator.pop(context, Imagen);
                  },
                  icon: Icon(Icons.clear)),
              Center(
                  child: Text(
                    "¿Como quiera cargar la Foto?",
                  ))
            ],
          ),
          content: Column(
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  child: Text("Tomar Fotografía"),
                  onPressed: () async {
                    await tomarFoto(context);
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Text("Galeria"),
                  onPressed: () async {
                    await galeriaFoto(context);
                  },
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Text("Eliminar Foto"),
                  onPressed: () {
                      Imagen = null;
                      Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        );
      });
}

tomarFoto(BuildContext context) async {
  var foto = await ImagePicker.pickImage(source: ImageSource.camera);
  if (foto != null) {
      Imagen = foto;
  }
}
galeriaFoto(BuildContext context) async {
  var foto = await ImagePicker.pickImage(source: ImageSource.gallery);
  if (foto != null) {
      Imagen = foto;
  }
}

