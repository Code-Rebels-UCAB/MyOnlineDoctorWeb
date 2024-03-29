
import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/cita/infraestructura/modelo/cita_finalizada.dart';
import 'dart:convert';

import '../../../../comun/enviroment.dart';
import '../../../../comun/environment.dart';
import '../../../../comun/infraestructura/autenticacion/puertos/auth_service_abstract.dart';
import '../../puertos/cita_request_abstract.dart';
import '../modelo/cita_iniciada.dart';



class LlamadaRequest implements CitaRequestAbstract {

  String url = SERVER_API;
  final AuthServiceAbstract authToken;

  LlamadaRequest(this.authToken);

  Future<CitaIniciada> obtenerDataVideollamada(String citaid) async {
    try {
      final token = await authToken.leerToken();
      final apiUrl = Uri.parse(url + "/api/cita/iniciarcita?citaid=" + citaid);
      final response = await http.put(apiUrl,
          headers: {"Access-Control-Allow-Origin": "*",
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
          }).timeout(const Duration(seconds: 15));
      final datosAExtraer = jsonDecode(response.body)['valor'];
      final iniciarLlamada =  CitaIniciada.fromJson(datosAExtraer);
      return iniciarLlamada;

    } catch(e) {
      throw Exception('Algo salió mal');
    }
  }

  Future<void> enviarDataVideollamadaFinalizada(String citaId) async {
    try {
      final apiUrl = Uri.parse(url + "/api/cita/finalizarcita?id=" + citaId);
      final response = await http.put(
          apiUrl,
          headers: {"Content-Type":"Aplication/json"}).timeout(const Duration(seconds: 15));
      //    final datosAExtraer = jsonDecode(response.body)['valor'];
      //    final finalizarCita =  CitaFinalizada.fromJson(datosAExtraer);
      return;
    } catch(e) {
    throw Exception('Algo salió mal');
    }
  }
}