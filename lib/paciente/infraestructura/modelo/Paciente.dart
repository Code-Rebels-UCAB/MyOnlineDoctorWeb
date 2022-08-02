// To parse this JSON data, do
//
//     final servicioSolicitud = servicioSolicitudFromJson(jsonString);

import 'dart:convert';

ServicioSolicitud servicioSolicitudFromJson(String str) => ServicioSolicitud.fromJson(json.decode(str));

String servicioSolicitudToJson(ServicioSolicitud data) => json.encode(data.toJson());

class ServicioSolicitud {
    ServicioSolicitud({
        required this.esExitoso,
        required this.valor,
    });

    bool esExitoso;
    List<Paciente> valor;

    factory ServicioSolicitud.fromJson(Map<String, dynamic> json) => ServicioSolicitud(
        esExitoso: json["esExitoso"],
        valor: List<Paciente>.from(json["valor"].map((x) => Paciente.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "esExitoso": esExitoso,
        "valor": List<dynamic>.from(valor.map((x) => x.toJson())),
    };
}

class Paciente {
    Paciente({
        required this.idPaciente,
        required this.pNombre,
        required this.sNombre,
        required this.pApellido,
        required this.sApellido,
        required this.sexo,
        required this.altura,
        required this.peso,
        required this.telefono,
        required this.antecedentes,
        required this.operacion,
        required this.statusSuscripcion,
        required this.alergia,
        required this.correo,
        required this.fechaNacimiento,
    });

    String idPaciente;
    String pNombre;
    String sNombre;
    String pApellido;
    String sApellido;
    String sexo;
    String altura;
    String peso;
    String telefono;
    String antecedentes;
    dynamic operacion;
    String statusSuscripcion;
    dynamic alergia;
    String correo;
    DateTime fechaNacimiento;

    factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        idPaciente: json["id_paciente"],
        pNombre: json["p_nombre"],
        sNombre: json["s_nombre"],
        pApellido: json["p_apellido"],
        sApellido: json["s_apellido"],
        sexo: json["sexo"],
        altura: json["altura"],
        peso: json["peso"],
        telefono: json["telefono"],
        antecedentes: json["antecedentes"],
        operacion: json["operacion"],
        statusSuscripcion: json["status_suscripcion"],
        alergia: json["alergia"],
        correo: json["correo"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
    );

    Map<String, dynamic> toJson() => {
        "id_paciente": idPaciente,
        "p_nombre": pNombre,
        "s_nombre": sNombre,
        "p_apellido": pApellido,
        "s_apellido": sApellido,
        "sexo": sexo,
        "altura": altura,
        "peso": peso,
        "telefono": telefono,
        "antecedentes": antecedentes,
        "operacion": operacion,
        "status_suscripcion": statusSuscripcion,
        "alergia": alergia,
        "correo": correo,
        "fecha_nacimiento": "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
    };
}
