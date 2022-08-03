
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/puertos/auth_service_abstract.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/storage/guardado_token_jwt.dart';

class AuthService implements AuthServiceAbstract {

  Future<bool> tieneToken() async {
    String? token = await GuardadoTokenJwt().leerToken();
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<void> borrarToken() async {
    await GuardadoTokenJwt().borrarToken();
  }

}