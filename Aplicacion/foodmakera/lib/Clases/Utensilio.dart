class Utensilio {
  String _objectId;
  String _nombre;
  String _descripcion;

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  String get objectId => _objectId;

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }


  set objectId(String value) {
    _objectId = value;
  }

  Utensilio(
      this._objectId, this._nombre, this._descripcion);
}