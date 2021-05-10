class Ingrediente{
  String _objectId;
  String _nombre;
  String _medida;

  Ingrediente(this._objectId, this._nombre);
  Ingrediente.todo(this._objectId, this._nombre, this._medida);

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }


  String get medida => _medida;

  set medida(String value) {
    _medida = value;
  }

  String get nombre => _nombre;

  set nombre(String value) {
    _nombre = value;
  }
}