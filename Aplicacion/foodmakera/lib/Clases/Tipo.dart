
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Tipo {
  String _objectId;
  int _id_tipo;
  String _nombre;

  String get objectId => _objectId;

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  int get id_tipo => _id_tipo;

  set id_tipo(int value) {
    _id_tipo = value;
  }

  set objectId(String value) {
    _objectId = value;
  }

  Tipo(this._id_tipo, this._nombre);

  Tipo.Completa(this._objectId, this._id_tipo, this._nombre);


  void  actualizarDB() async {
    if (this.nombre.isNotEmpty && this._id_tipo != null
        && this._objectId.isNotEmpty) {
        var tipo = ParseObject('Tipo')
            ..objectId = this._objectId
            ..set('nombre', this._nombre);
        await tipo.save();
    }
  }
}