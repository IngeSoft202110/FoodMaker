import 'package:foodmakera/Clases/Comentario.dart';
import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'User.dart';
import 'Ingrediente.dart';
import 'Paso.dart';
import 'Tipo.dart';

class Receta {
  List<Comentario> _comentarios;
  Dieta _dieta;
  Region _region;
  Tipo _tipo;
  List<Utensilio> _utensilios;
  String _Nombre;
  String _descripcion;
  String _url;
  int _visitas;
  int _tiempo;
  List<Paso> _pasos;
  String _objectId;
  List<Ingrediente> _ingredientes;
  User _usuario;

  List<Utensilio> get utensilios => _utensilios;

  // ignore: unnecessary_getters_setters
  String get objectId => _objectId;

  // ignore: unnecessary_getters_setters
  set objectId(String value) {
    _objectId = value;
  }

  // ignore: unnecessary_getters_setters
  set utensilios(List<Utensilio> value) {
    _utensilios = value;
  }

  // ignore: unnecessary_getters_setters
  Dieta get dieta => _dieta;

  // ignore: unnecessary_getters_setters
  set dieta(Dieta value) {
    _dieta = value;
  }

  Region get region => _region;

  set region(Region value) {
    _region = value;
  }

  Tipo get tipo => _tipo;

  set tipo(Tipo value) {
    _tipo = value;
  }

  String get Nombre => _Nombre;

  set Nombre(String value) {
    _Nombre = value;
  }

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  int get visitas => _visitas;

  set visitas(int value) {
    _visitas = value;
  }

  int get tiempo => _tiempo;

  set tiempo(int value) {
    _tiempo = value;
  }

  List<Paso> get pasos => _pasos;

  set pasos(List<Paso> value) {
    _pasos = value;
  }

  List<Ingrediente> get ingredientes => _ingredientes;

  set ingredientes(List<Ingrediente> value) {
    _ingredientes = value;
  }

  User get usuario => _usuario;

  set usuario(User value) {
    _usuario = value;
  }


  List<Comentario> get comentarios => _comentarios;

  set comentarios(List<Comentario> value) {
    _comentarios = value;
  }

  Receta.vacia();

  Receta(
      this._dieta,
      this._region,
      this._tipo,
      this._utensilios,
      this._Nombre,
      this._descripcion,
      this._url,
      this._visitas,
      this._tiempo,
      this._pasos,
      this._ingredientes,
      this._objectId,
      this._usuario,
      this._comentarios);
}
