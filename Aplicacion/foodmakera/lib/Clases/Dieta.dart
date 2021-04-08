
//import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Dieta {
  String _objectId;
  int _id_dienta;
  String _nombre;

  String get objectId => _objectId;

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  int get id_dienta => _id_dienta;

  set id_dienta(int value) {
    _id_dienta = value;
  }

  set objectId(String value) {
    _objectId = value;
  }

  Dieta(this._id_dienta, this._nombre);

  Dieta.Completa(this._objectId, this._id_dienta, this._nombre);

/* void crearDB() async{
    if (this.nombre.isNotEmpty){
      var dieta = ParseObject('Dieta')
          ..setIncrement('id_dieta', 1)
          ..set('nombre',this.nombre);
          var respuesta =await dieta.save();
          if(respuesta.success){
            dieta = respuesta.results.first;
          }
    }
  }*/

  /*void  actualizarDB() async {
    if (this.nombre.isNotEmpty && this._id_dienta != null
        && this._objectId.isNotEmpty) {
        var dieta = ParseObject('Dieta')
            ..objectId = this._objectId
            ..set('nombre', this._nombre);
        await dieta.save();
    }
  }*/
}