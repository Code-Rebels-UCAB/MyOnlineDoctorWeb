import 'videollamada/modelo/cita.dart';

abstract class CitaRequestAbstract {
  Future<Cita> obtenerDataVideollamada(String citaid);
}