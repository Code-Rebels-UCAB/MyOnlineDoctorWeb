
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:myonlinedoctorweb/comun/infraestructura/videollamada_cita.dart';

class IniciarLlamadaRequest {

  String url = 'http://10.0.2.2:3000';

  Future<VideollamadaCita> obtenerDataVideollamada(String citaid) async {
    try {
      final apiUrl = Uri.parse(url + "api/cita/citaIniciada/" + citaid);
      final response = await http.get(apiUrl).timeout(const Duration(seconds: 15));
      final datosAExtraer = jsonDecode(response.body)['valor'];
      final iniciarLlamada = datosAExtraer.map<VideollamadaCita>((e) => VideollamadaCita.fromJson(e)).toList();
      return iniciarLlamada;

    } catch(e) {
      print(e);
      throw Exception('Algo salió mal');
    }
  }
}