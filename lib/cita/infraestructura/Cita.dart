// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

import 'package:myonlinedoctorweb/paciente/infraestructura/Paciente.dart';



ResponseCitas responseCitasApiFromJson(String str) =>
    ResponseCitas.fromJson(json.decode(str));

class ResponseCitas {
  ResponseCitas({
    required this.esExitoso,
    required this.valor,
  });

  bool esExitoso;
  List<Cita> valor;

  factory ResponseCitas.fromJson(Map<String, dynamic> json) => ResponseCitas(
        esExitoso: json["esExitoso"],
        valor: List<Cita>.from(json["valor"].map((x) => Cita.fromJson(x))),
      );
}

class Cita {
  Cita({
    this.idCita,
    this.statuscita,
    this.modalidad,
    this.motivo,
    this.fechacita,
    this.horacita,
    this.duracion,
    required this.paciente,
  });

  String? idCita;
  String? statuscita;
  String? modalidad;
  String? motivo;
  String? fechacita;
  String? horacita;
  int? duracion;
  Paciente paciente;

  factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        idCita: json["id_cita"],
        statuscita: json["statuscita"],
        modalidad: json["modalidad"],
        motivo: json["motivo"],
        fechacita: json["fechacita"],
        horacita: json["horacita"],
        duracion: json["duracion"],
        paciente: Paciente.fromJson(json["paciente"]),
      );
}
