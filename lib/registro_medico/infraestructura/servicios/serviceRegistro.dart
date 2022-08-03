import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedico.dart';

import '../../../comun/enviroment.dart';

class ServiceRegistroMedico {
  static String urlLocal = SERVER_API;

  static Future<List<RegistroMedico>?> getTodosRegistrosPcte(
      String idPaciente) async {
    final url = Uri.parse(
        urlLocal + '/api/registroMedico/getByPaciente?idPaciente=$idPaciente');
    final http.Response response;
    try {
      response = await http.get(url);
    } catch (e) {
      // throw Exception('El servidor esta inactivo - ServerDown');
      print(e);
      return null;
    }
    final List jsonData;
    List<RegistroMedico>? citas;
    ServicioRegistroMed respCi;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      if (body.isNotEmpty) {
        respCi = servicioRegistroMedFromJson(body);
        citas = respCi.valor;
        return citas;
      } else {
        return citas = [];
      }
    } else {
      return citas;
    }
  }

  static Future<List<RegistroMedico>?> crearRegistroMed(RegistroMedico nuevoRegistro) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://localhost:3000/api/registroMedico/crear'));
    request.body = json.encode({
      "IdCita": nuevoRegistro.idCita,
      "IdDoctor": nuevoRegistro.idDoctor,
      "examenes": nuevoRegistro.examenes,
      "historia": nuevoRegistro.historia,
      "prescripcion": nuevoRegistro.prescripcion,
      "plan": nuevoRegistro.plan,
      "diagnostico": nuevoRegistro.diagnostico
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
