import 'package:myonlinedoctorweb/cita/infraestructura/modelo/Cita.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedico.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/servicios/serviceRegistro.dart';

class RegistroMedStream {
  static Stream<List<RegistroMedico>?> streamTodasRegistros(String idPaciente) async* {
    var registrosMedList = await ServiceRegistroMedico.getTodosRegistrosPcte(idPaciente);
    yield registrosMedList;
  }
}
