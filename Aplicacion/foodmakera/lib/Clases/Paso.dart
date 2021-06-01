



class Paso {
  String _objectID;
  int _numero;
  String _especificacion;
  String _fotourl;
  var _foto;
  String get objectID => _objectID;

  set objectID(String value) {
    _objectID = value;
  }

  int get numero => _numero;

  String get fotourl => _fotourl;

  set fotourl(String value) {
    _fotourl = value;
  }

  String get especificacion => _especificacion;

  set especificacion(String value) {
    _especificacion = value;
  }

  set numero(int value) {
    _numero = value;
  }

  get foto => _foto;

  set foto(value) {
    _foto = value;
  }
  Paso.crearDB(this._objectID, this._numero, this._especificacion, this._foto);
  Paso(this._objectID, this._numero, this._especificacion, this._fotourl);
  Paso.crear(this._numero,this._especificacion,this._fotourl);
}