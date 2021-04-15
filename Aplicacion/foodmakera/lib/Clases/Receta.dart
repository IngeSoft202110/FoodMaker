import 'package:foodmakera/Clases/Dieta.dart';
import 'package:foodmakera/Clases/Region.dart';
import 'package:foodmakera/Clases/Utensilio.dart';
import 'Tipo.dart';

class Receta{
Dieta _dieta;
Region _region;
Tipo _tipo;
Utensilio _utensilio;
String _Nombre;
String _descripcion;
String _url;
int _visitas;
int _tiempo;
String _pasos;

Dieta get dieta => _dieta;

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

Utensilio get utensilio => _utensilio;

  set utensilio(Utensilio value) {
    _utensilio = value;
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

String get pasos => _pasos;

  set pasos(String value) {
    _pasos = value;
  }

Receta(this._dieta, this._region, this._tipo, this._utensilio, this._Nombre,
      this._descripcion, this._url, this._visitas, this._tiempo, this._pasos);
}