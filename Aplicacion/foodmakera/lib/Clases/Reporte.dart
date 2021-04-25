class Reporte{
  String _objectId;
  String _nombreReceta;
  String _tipo;
  String _nombre;
  String _estado;
  String _idUsuario;

  String get estado => _estado;

  set estado(String value) {
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

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  Reporte(this._objectId, this._nombreReceta, this._tipo, this._nombre,
      this._estado);

}