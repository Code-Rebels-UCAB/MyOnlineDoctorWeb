
import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/cita/infraestructura/videollamada/puertos/cita_request_abstract.dart';
import 'dart:convert';

import '../modelo/cita_iniciada.dart';



class IniciarLlamadaRequest implements CitaRequestAbstract {

  String url = 'http://127.0.0.1:3000';

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
}