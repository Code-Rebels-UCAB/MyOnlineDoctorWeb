
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../modelos/token_jwt.dart';

class GuardadoTokenJwt {
  final _almacenamiento = const FlutterSecureStorage();

  Future<void> escribirDataToken(TokenJwtModelo token) async {
    await _almacenamiento.write(
        key: 'token', value: token.token.toString());
  }

  borrarToken() async {
    await _almacenamiento.deleteAll();
  }

  Future<String> leerToken() async {
    return await _almacenamiento.read(key: 'token') as String;
  }
}