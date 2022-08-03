import 'dart:async';

abstract class AuthServiceAbstract {
  Future<bool> tieneToken();
  Future<void> borrarToken();

}