import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedico.dart';

import '../../../comun/enviroment.dart';
import '../../../comun/environment.dart';
import '../../../comun/infraestructura/autenticacion/auth_service.dart';
import '../../../comun/infraestructura/autenticacion/storage/guardado_token_jwt.dart';

class ServiceRegistroMedico {
  static String urlLocal = SERVER_API;

  static Future<List<RegistroMedico>?> getTodosRegistrosPcte(
      String idPaciente) async {
    final url = Uri.parse(
        urlLocal + '/api/registroMedico/getByPacienteWeb?id=$idPaciente');
    final http.Response response;
    try {
      response = await http.get(url);
    } catch (e) {
      // throw Exception('El servidor esta inactivo - ServerDown');
      print(e);
      return null;
    }
    final List jsonData;
    List<RegistroMedico>? registros;
    ServicioRegistroMed respCi;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      if (body.isNotEmpty) {
        respCi = servicioRegistroMedFromJson(body);
        registros = respCi.valor;
        return registros;
      } else {
        return registros = [];
      }
    } else {
      return registros;
    }
  }

  static Future<List<RegistroMedico>?> crearRegistroMed(RegistroMedico nuevoRegistro) async {
    final token = await AuthService(authToken: GuardadoTokenJwt()).leerToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request(
        'POST', Uri.parse(urlLocal + '/api/registroMedico/crear'));
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
