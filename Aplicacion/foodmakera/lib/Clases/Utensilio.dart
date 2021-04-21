class Utensilio {
  String _objectId;
  int _id_utensilio;
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

  int get id_utensilio => _id_utensilio;

  set id_utensilio(int value) {
    _id_utensilio = value;
  }

  set objectId(String value) {
    _objectId = value;
  }

  Utensilio(
      this._objectId, this._id_utensilio, this._nombre, this._descripcion);
}