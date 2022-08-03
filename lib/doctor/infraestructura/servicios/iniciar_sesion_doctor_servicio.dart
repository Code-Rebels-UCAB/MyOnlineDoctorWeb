

import 'dart:convert';
import 'dart:io';
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/puertos/auth_service_abstract.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/modelos/IniciarSesionDoctorModelo.dart';
import 'package:http/http.dart' as http;
import 'package:myonlinedoctorweb/doctor/infraestructura/puertos/doctor_servicio_abstract.dart';
import '../../../comun/environment.dart';
import '../../../comun/infraestructura/autenticacion/storage/guardado_token_jwt.dart';
import '../../../comun/infraestructura/modelos/token_jwt.dart';


class IniciarSesionDoctorServicio implements DoctorServicioAbstract{

  String url = SERVER_API;
  final AuthServiceAbstract authToken;

  IniciarSesionDoctorServicio(this.authToken);

  Future<TokenJwtModelo> iniciarSesionDoctorRequest(IniciarSesionDoctorModelo credenciales) async {
    try {
      final apiUrl = Uri.parse(url + "/api/doctor/autenticar");
      final response = await http.put(
        apiUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode({
          "correo": credenciales.correoDoctor, "password": credenciales.passwordDoctor
        }),
      ).timeout(const Duration(seconds: 15));
      final respuestaExtraida = json.decode(response.body)['valor'];
      final token = TokenJwtModelo.fromJson(respuestaExtraida);
      await authToken.escribirDataToken(token);
      return token;
    } catch (e) {
      throw Exception('Algo salio mal');
    }
  }
}