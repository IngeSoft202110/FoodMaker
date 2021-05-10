class Region {
  String _objectId;
  int _id_tipo;
  String _nombre;

  String get objectId => _objectId;

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  int get id_tipo => _id_tipo;

  set id_tipo(int value) {
    _id_tipo = value;
  }

  set objectId(String value) {
    _objectId = value;
  }

  Region(this._id_tipo, this._nombre);
  Region.vacio();
  Region.Completa(this._objectId, this._id_tipo, this._nombre);

}