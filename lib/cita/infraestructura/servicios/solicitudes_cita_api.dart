import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../comun/environment.dart';
import '../modelo/Cita.dart';


class ServiceCitaSolicitud {
  // ignore: unused_element

  static String urlLocal =  'http://127.0.0.1:3000';
  //static String urlLocal = SERVER_API;

  static Future<List<Cita>?> getTodasSolicituaestructurdes() async {
    final url = Uri.parse(
        urlLocal + '/api/cita/getcitasdoctor/dd2d571a-aadf-4213-a81f-ade5f5e89893');
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
        urlLocal + '/api/cita/citasAlDiadoctor/dd2d571a-aadf-4213-a81f-ade5f5e89893');
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

  static Future<List<Cita>?> getCitasSolicitadas() async {
    final url = Uri.parse(
        urlLocal + '/api/cita/getsolicitudesdoctor/dd2d571a-aadf-4213-a81f-ade5f5e89893');
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
}
