// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

import 'package:myonlinedoctorweb/models/Paciente.dart';

ResponseCitas responseCitasApiFromJson(String str) => ResponseCitas.fromJson(json.decode(str));

String responseCitasApiToJson(ResponseCitas data) => json.encode(data.toJson());

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

    Map<String, dynamic> toJson() => {
        "esExitoso": esExitoso,
        "valor": List<dynamic>.from(valor.map((x) => x.toJson())),
    };
}

class Cita {
    Cita({
        required this.idCita,
        required this.statuscita,
        required this.modalidad,
        required this.horacita,
        required this.paciente,
    });

    String idCita;
    String statuscita;
    String modalidad;
    String horacita;
    Paciente paciente;

    factory Cita.fromJson(Map<String, dynamic> json) => Cita(
        idCita: json["id_cita"],
        statuscita: json["statuscita"],
        modalidad: json["modalidad"],
        horacita: json["horacita"],
        paciente: Paciente.fromJson(json["paciente"]),
    );

    Map<String, dynamic> toJson() => {
        "id_cita": idCita,
        "statuscita": statuscita,
        "modalidad": modalidad,
        "horacita": horacita,
        "paciente": paciente.toJson(),
    };
}
