import 'package:myonlinedoctorweb/cita/infraestructura/modelo/Cita.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';

class CitaStream {
  static Stream<List<Cita>?> streamCitas() async* {
    var citasList = await ServiceCitaApi.getTodasCitas();
    yield citasList;
  }
}
