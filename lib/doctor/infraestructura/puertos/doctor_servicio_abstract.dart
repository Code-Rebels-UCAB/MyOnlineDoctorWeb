

import '../../../comun/infraestructura/modelos/token_jwt.dart';
import '../modelos/IniciarSesionDoctorModelo.dart';

abstract class DoctorServicioAbstract {
  Future<TokenJwtModelo> iniciarSesionDoctorRequest(IniciarSesionDoctorModelo credenciales);
}