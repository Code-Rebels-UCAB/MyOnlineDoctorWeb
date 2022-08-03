import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/auth_service.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/storage/guardado_token_jwt.dart';

import '../../../comun/enviroment.dart';
import '../../../comun/environment.dart';
import '../../../comun/infraestructura/autenticacion/puertos/auth_service_abstract.dart';
import '../modelo/Cita.dart';

class ServiceCitaApi {
  // ignore: unused_element

  static String urlLocal = SERVER_API;


  static Future<List<Cita>?> getTodasCitas() async {
    final token = await AuthService(authToken: GuardadoTokenJwt()).leerToken();
    final url = Uri.parse(
        urlLocal + '/api/cita/getcitasdoctor');
    final http.Response response;
    try {
      response = await http.get(url,
        headers:{
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },);
    } catch (e) {
      // throw Exception('El servidor esta inactivo - ServerDown');
      print(e);
      return null;
    }
    final List jsonData;
    List<Cita>? citas;
    ResponseCitas respCi;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      if (body.isNotEmpty) {
        respCi = responseCitasApiFromJson(body);
        citas = respCi.valor;
        return citas;
      } else {
        return citas = [];
      }
    } else {
      return citas;
    }
  }

  static Future<List<Cita>?> getCitasDia() async {
    final token = await AuthService(authToken: GuardadoTokenJwt()).leerToken();
    final url = Uri.parse(
        urlLocal + '/api/cita/citasAlDiadoctor');
    final http.Response response;
    try {
      response = await http.get(url,
        headers:{
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },);
    } catch (e) {
      // throw Exception('El servidor esta inactivo - ServerDown');
      print(e);
      return null;
    }
    final List jsonData;
    List<Cita>? citas;
    ResponseCitas respCi;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      if (body.isNotEmpty) {
        respCi = responseCitasApiFromJson(body);
        citas = respCi.valor;
        return citas;
      } else {
        return citas = [];
      }
    } else {
      return citas;
    }
  }

  static Future<List<Cita>?> getCitasSolicitadas() async {
    final token = await AuthService(authToken: GuardadoTokenJwt()).leerToken();
    final url = Uri.parse(
        '${SERVER_API}/api/cita/getsolicitudesdoctor');
    final http.Response response;
    try {
      response = await http.get(url,
        headers:{
          "Content-type": "application/json",
          'Authorization': 'Bearer $token',
        },);
    } catch (e) {
      // throw Exception('El servidor esta inactivo - ServerDown');
      print(e);
      return null;
    }
    final List jsonData;
    List<Cita>? citas;
    ResponseCitas respCi;

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      if (body.isNotEmpty) {
        respCi = responseCitasApiFromJson(body);
        citas = respCi.valor;
        return citas;
      } else {
        return citas = [];
      }
    } else {
      return citas;
    }
  }

  static Future<void> agendarCita(
      String idCita, String fecha, String? hora) async {
    final token = await AuthService(authToken: GuardadoTokenJwt()).leerToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request('PUT',
        Uri.parse(urlLocal + '/api/cita/putagendarcita/$idCita'));
    request.body = json.encode({
      "idCita": idCita,
      "fechaCita": fecha,
      "horaCita": hora,
      "duracion": "60"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future<void> suspenderCita(String idCita) async {
    final token = await AuthService(authToken: GuardadoTokenJwt()).leerToken();
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            urlLocal + '/api/cita/suspendercita?citaId=$idCita'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
