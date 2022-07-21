
import '../modelo/cita_finalizada.dart';
import '../videollamada/modelo/cita_iniciada.dart';

abstract class CitaRequestAbstract {
  Future<CitaIniciada> obtenerDataVideollamada(String citaid);
  Future<void> enviarDataVideollamadaFinalizada(String citaid);
}