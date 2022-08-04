import 'package:myonlinedoctorweb/cita/infraestructura/modelo/Cita.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacientes_model.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/servicios/paciente_service.dart';

class PacienteStream {
  static Stream<List<dynamic>> streamTodosPacientes(String dropdown, String texto) async* {
    var pacientesList = await PacienteService.getPacientes(dropdown, texto);
    yield pacientesList;
  }
}
