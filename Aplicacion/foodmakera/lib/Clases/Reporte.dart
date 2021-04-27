class Reporte{
  String _nombreReceta;
  String _tipo;
  String _nombre;
  bool _estado;
  String _idUsuario;

  bool get estado => _estado;

  set estado(bool value) {
    _estado = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get nombreReceta => _nombreReceta;

  set nombreReceta(String value) {
    _nombreReceta = value;
  }

  Reporte.vacio();
  Reporte( this._nombreReceta, this._tipo, this._nombre,
      this._estado);

}