class User{
  String _username;
  String _objectId;
  String _correo;

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get objectId => _objectId;

  String get correo => _correo;

  set correo(String value) {
    _correo = value;
  }

  set objectId(String value) {
    _objectId = value;
  }
  User.vacio();
  User.incompleto(this._username, this._objectId); //No tocar, si necesita cree otro constructor
}


