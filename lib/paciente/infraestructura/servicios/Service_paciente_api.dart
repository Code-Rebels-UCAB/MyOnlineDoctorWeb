import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/Paciente.dart';

class PacienteService {
  Future<List<dynamic>> getPacientes(
      String dropdownFilter, String searchValue) async {
    // ignore: prefer_typing_uninitialized_variables
    var response;

    if (dropdownFilter == 'Nombre y Apellido' && searchValue.isNotEmpty) {
      response = await http.get(Uri.parse(
          "http://localhost:3000/api/paciente/filtrar/nombre?nombre=$searchValue"));
    } else if (dropdownFilter == 'Telefono' && searchValue.isNotEmpty) {
      response = await http.get(Uri.parse(
          "http://localhost:3000/api/paciente/filtrar/telefono?telefono=$searchValue"));
    }
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse["valor"]
        .map((doctors) => Paciente.fromJson(doctors))
        .toList();
  }
}
