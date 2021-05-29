

import 'package:foodmakera/Clases/Receta.dart';

class User{
  String _username;
  String _objectId;
  String _correo;
  String _descripcion;
  int _seguidores;
  String _pais;
  List<Receta> _guardades;


  List<Receta> get guardades => _guardades;

  set guardades(List<Receta> value) {
    _guardades = value;
  }

  int get seguidores => _seguidores;

  String get pais => _pais;

  set pais(String value) {
    _pais = value;
  }

  set seguidores(int value) {
    _seguidores = value;
  }

  String get username => _username;
  String get objectId => _objectId;
  String get correo => _correo;
  String get descripcion => _descripcion;


  set username(String value) {
    _username = value;
  }
  set correo(String value) {
    _correo = value;
  }

  set objectId(String value) {
    _objectId = value;
  }

  set descripcion(String value)
  {
    _descripcion = value;
  }
  User.vacio();
  User.incompleto(this._username, this._objectId); //No tocar, si necesita cree otro constructor
  User.completo(this._username,this._descripcion,this._correo,this._objectId,this._seguidores,this._pais, this._guardades);
}


