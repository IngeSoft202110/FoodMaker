 class Ingrediente{
  String _objectId;
  int _id_ingrediente;
  String _nombre;
  String _medida;

  Ingrediente(this._objectId, this._id_ingrediente, this._nombre);

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  int get id_ingrediente => _id_ingrediente;

  String get medida => _medida;

  set medida(String value) {
    _medida = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }

  set id_ingrediente(int value) {
    _id_ingrediente = value;
  }
}