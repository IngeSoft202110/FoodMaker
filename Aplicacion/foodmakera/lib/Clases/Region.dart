class Region {
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

  Region(this._nombre);
  Region.vacio();
  Region.Completa(this._objectId, this._nombre);

}