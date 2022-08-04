

import '../../../comun/infraestructura/modelos/token_jwt.dart';
import '../modelos/IniciarSesionDoctorModelo.dart';
import '../modelos/datos_doctor.dart';

abstract class DoctorServicioAbstract {
  Future<TokenJwtModelo> iniciarSesionDoctorRequest(IniciarSesionDoctorModelo credenciales);
  Future<DatosDoctorModelo> obtenerDatosDoctorPerfil();
}