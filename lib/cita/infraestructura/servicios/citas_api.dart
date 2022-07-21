import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../modelo/Cita.dart';

class ServiceCitaApi {
  // ignore: unused_element
  static Future<List<Cita>?> getTodasCitas() async {
    final url = Uri.parse(
        'http://localhost:3000/api/cita/getcitasdoctor/dd2d571a-aadf-4213-a81f-ade5f5e89893');
    final http.Response response;
    try {
      response = await http.get(url);
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
    final url = Uri.parse(
        'http://localhost:3000/api/cita/citasAlDiadoctor/dd2d571a-aadf-4213-a81f-ade5f5e89893');
    final http.Response response;
    try {
      response = await http.get(url);
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
      String idCita, String fecha, TimeOfDay? hora) async {
    var horaString =
        hora!.hour.toString() + ':' + hora.minute.toString() + ':00';
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('PUT',
        Uri.parse('http://localhost:3000/api/cita/putagendarcita/$idCita'));
    request.body = json.encode({
      "idCita": idCita,
      "fechaCita": fecha,
      "horaCita": horaString,
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
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'PUT',
        Uri.parse(
            'http://localhost:3000/api/cita/suspendercita?citaId=$idCita'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
