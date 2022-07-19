import '../../comun/infraestructura/videollamada_cita.dart';

abstract class CitaRequestAbstract {
  Future<VideollamadaCita> obtenerDataVideollamada(String citaid);
}