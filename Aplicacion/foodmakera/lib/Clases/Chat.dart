import 'Mensaje.dart';

class Chat {
  String _objectId;
  String _idUsuario1;
  String _idUsuario2;
  List<Mensaje> _mensajes;

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  String get idUsuario1 => _idUsuario1;

  String get idUsuario2 => _idUsuario2;

  set idUsuario2(String value) {
    _idUsuario2 = value;
  }

  set idUsuario1(String value) {
    _idUsuario1 = value;
  }

  List<Mensaje> get mensajes => _mensajes;

  set mensajes(List<Mensaje> value) {
    _mensajes = value;
  }

  Chat(this._objectId, this._idUsuario1, this._idUsuario2);
}