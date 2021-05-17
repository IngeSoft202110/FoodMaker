class Tipo {
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

  Tipo(this._nombre);
  Tipo.vacio();
  Tipo.Completa(this._objectId, this._nombre);

}