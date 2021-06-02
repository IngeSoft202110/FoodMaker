import 'package:foodmakera/Clases/User.dart';

class Calificacion{
  String _objectId;
  double _puntos;
  User _usuario;

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  double get puntos => _puntos;

  set puntos(double value) {
    _puntos = value;
  }

  User get usuario => _usuario;

  set usuario(User value) {
    _usuario = value;
  }

  Calificacion(this._objectId, this._puntos, this._usuario);
}