
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
  Dieta.vacia();
  Dieta.Completa(this._objectId, this._id_dienta, this._nombre);


}