
//import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Dieta {
  String _objectId;
  String _nombre;

  String get objectId => _objectId;

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  set objectId(String value) {
    _objectId = value;
  }

  Dieta(this._nombre);
  Dieta.vacia();
  Dieta.Completa(this._objectId, this._nombre);


}