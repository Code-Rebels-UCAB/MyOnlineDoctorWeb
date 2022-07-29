
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../comun/environment.dart';
import '../modelo/cita_iniciada.dart';



class LlamadaRequest implements CitaRequestAbstract {

  String url = SERVER_API;

  Future<CitaIniciada> obtenerDataVideollamada(String citaid) async {
    try {
      final apiUrl = Uri.parse(url + "/api/cita/iniciarcita?citaid=" + citaid);
      final response = await http.put(apiUrl, headers: {"Access-Control-Allow-Origin": "*"}).timeout(const Duration(seconds: 15));
      final datosAExtraer = jsonDecode(response.body)['valor'];
      final iniciarLlamada =  CitaIniciada.fromJson(datosAExtraer);
      return iniciarLlamada;

    } catch(e) {
      throw Exception('Algo salió mal');
    }
  }

  Future<void> enviarDataVideollamadaFinalizada(String citaId) async {
    try {
      final apiUrl = Uri.parse(url + "/api/cita/finalizarcita?citaid=" + citaId);
      final response = await http.put(
          apiUrl,
          headers: {"Content-Type":"Aplication/json"}).timeout(const Duration(seconds: 15));
    //final datosAExtraer = jsonDecode(response.body)['valor'];
    //final finalizarCita =  CitaFinalizada.fromJson(datosAExtraer);
    //return finalizarCita;

    } catch(e) {
    throw Exception('Algo salió mal');
    }
  }
}