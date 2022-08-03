// To parse this JSON data, do
//
//     final servicioRegistroMed = servicioRegistroMedFromJson(jsonString);

import 'dart:convert';

ServicioRegistroMed servicioRegistroMedFromJson(String str) =>
    ServicioRegistroMed.fromJson(json.decode(str));

String servicioRegistroMedToJson(ServicioRegistroMed data) =>
    json.encode(data.toJson());

class ServicioRegistroMed {
  ServicioRegistroMed({
    required this.esExitoso,
    required this.valor,
  });

  bool esExitoso;
  List<RegistroMedico> valor;

  factory ServicioRegistroMed.fromJson(Map<String, dynamic> json) =>
      ServicioRegistroMed(
        esExitoso: json["esExitoso"],
        valor: List<RegistroMedico>.from(json["valor"].map((x) => RegistroMedico.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "esExitoso": esExitoso,
        "valor": List<dynamic>.from(valor.map((x) => x.toJson())),
      };
}

class RegistroMedico {
  RegistroMedico({
    this.idRegistro,
    required this.examenes,
    required this.historia,
    required this.prescripcion,
    required this.plan,
    required this.diagnostico,
    this.motivo,
    this.fechaCita,
    this.modalidad,
    required this.idDoctor,
    this.nombreDoctor,
    this.sexoDoctor,
    required this.idCita,
    this.idPaciente,
    this.idHistoria,
  });

  String? idRegistro;
  String examenes;
  String historia;
  String prescripcion;
  String plan;
  String diagnostico;
  String? motivo;
  DateTime? fechaCita;
  String? modalidad;
  String idDoctor;
  String? nombreDoctor;
  String? sexoDoctor;
  String idCita;
  String? idPaciente;
  String? idHistoria;

  factory RegistroMedico.fromJson(Map<String, dynamic> json) => RegistroMedico(
        idRegistro: json["id_registro"],
        examenes: json["examenes"],
        historia: json["historia"],
        prescripcion: json["prescripcion"],
        plan: json["plan"],
        diagnostico: json["diagnostico"],
        motivo: json["motivo"],
        fechaCita: DateTime.parse(json["fechaCita"]),
        modalidad: json["modalidad"],
        idDoctor: json["id_doctor"],
        nombreDoctor: json["nombreDoctor"],
        sexoDoctor: json["sexoDoctor"],
        idCita: json["id_cita"],
        idPaciente: json["id_paciente"],
        idHistoria: json["id_historia"],
      );

  Map<String, dynamic> toJson() => {
        "id_registro": idRegistro,
        "examenes": examenes,
        "historia": historia,
        "prescripcion": prescripcion,
        "plan": plan,
        "diagnostico": diagnostico,
        "motivo": motivo,
        "fechaCita":
            "${fechaCita!.year.toString().padLeft(4, '0')}-${fechaCita!.month.toString().padLeft(2, '0')}-${fechaCita!.day.toString().padLeft(2, '0')}",
        "modalidad": modalidad,
        "id_doctor": idDoctor,
        "nombreDoctor": nombreDoctor,
        "sexoDoctor": sexoDoctor,
        "id_cita": idCita,
        "id_paciente": idPaciente,
        "id_historia": idHistoria,
      };
}
