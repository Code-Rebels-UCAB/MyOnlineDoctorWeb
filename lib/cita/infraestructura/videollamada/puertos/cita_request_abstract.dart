import '../modelo/cita_iniciada.dart';


abstract class CitaRequestAbstract {
  Future<CitaIniciada> obtenerDataVideollamada(String citaid);
}