import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/comun/enviroment.dart';
import 'dart:convert';

import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacientes_model.dart';

class PacienteService {
  static String urlLocal = SERVER_API;

  Future<List<dynamic>> getPacientes(
      String dropdownFilter, String searchValue) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;

    if (dropdownFilter == 'Nombre y Apellido' && searchValue.isNotEmpty) {
      response = await http.get(Uri.parse(
          urlLocal + "/api/paciente/filtrar/nombre?nombre=$searchValue"));
    } else if (dropdownFilter == 'Telefono' && searchValue.isNotEmpty) {
      response = await http.get(Uri.parse(
          urlLocal + "/api/paciente/filtrar/telefono?telefono=$searchValue"));
    } else {
      response =
          await http.get(Uri.parse(urlLocal + "/api/paciente/todos"));
    }

    var jsonResponse = jsonDecode(response.body);
    return jsonResponse["valor"]
        .map((pacientes) => PacienteModel.fromJson(pacientes))
        .toList();
  }

}
