class Mensaje {
  String _objectId;
  String _idRemitente;
  String _mensaje;
  DateTime _fecha;

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  String get idRemitente => _idRemitente;

  DateTime get fecha => _fecha;

  set fecha(DateTime value) {
    _fecha = value;
  }

  String get mensaje => _mensaje;

  set mensaje(String value) {
    _mensaje = value;
  }

  set idRemitente(String value) {
    _idRemitente = value;
  }

  Mensaje(this._objectId, this._idRemitente, this._mensaje, this._fecha);
}