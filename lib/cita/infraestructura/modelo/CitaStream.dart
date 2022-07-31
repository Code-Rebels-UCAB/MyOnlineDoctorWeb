import 'package:myonlinedoctorweb/cita/infraestructura/modelo/Cita.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';

class CitaStream {
  static Stream<List<Cita>?> streamTodasCitas() async* {
    var citasList = await ServiceCitaApi.getTodasCitas();
    yield citasList;
  }

  static Stream<List<Cita>?> streamCitasSolicitadas() async* {
    var citasList = await ServiceCitaApi.getCitasSolicitadas();
    yield citasList;
  }
}
