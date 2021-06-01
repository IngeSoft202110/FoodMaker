import 'Ingrediente.dart';


class IngredientexReceta{
  Ingrediente _ingriente;
  int _cant;
  String _objectId;

  Ingrediente get ingriente => _ingriente;

  set ingriente(Ingrediente value) {
    _ingriente = value;
  }

  int get cant => _cant;

  set cant(int value){
    _cant = value;
  }

  get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  IngredientexReceta(this._ingriente, this._cant, this._objectId);
}