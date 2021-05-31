
import 'User.dart';

class Comentario{
  String _descripcion;
  String _objectId;
  User _hizoComentario;
  List<User> _like;
  List<User> _dislike;
  int _clike;
  int _cdislike;

  String get descripcion => _descripcion;

  set descripcion(String value) {
    _descripcion = value;
  }

  String get objectId => _objectId;

  set objectId(String value) {
    _objectId = value;
  }

  List<User> get like => _like;

  set like(List<User> value) {
    _like = value;
  }

  int get cdislike => _cdislike;

  set cdislike(int value) {
    _cdislike = value;
  }

  int get clike => _clike;

  set clike(int value) {
    _clike = value;
  }

  List<User> get dislike => _dislike;

  set dislike(List<User> value) {
    _dislike = value;
  }

  User get hizoComentario => _hizoComentario;

  set hizoComentario(User value) {
    _hizoComentario = value;
  }
  Comentario.crearBD(this._descripcion, this._hizoComentario);

  Comentario.query(this._descripcion, this._objectId, this._hizoComentario,
      this._clike, this._cdislike);

  Comentario.crear(this._descripcion, this._objectId, this._hizoComentario,
      this._like, this._dislike);
}

