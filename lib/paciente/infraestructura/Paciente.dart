class Paciente {
    Paciente({
        required this.idPaciente,
        required this.pNombre,
        required this.pApellido,
    });

    String idPaciente;
    String pNombre;
    String pApellido;

    factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        idPaciente: json["id_paciente"],
        pNombre: json["p_nombre"],
        pApellido: json["p_apellido"],
    );

    Map<String, dynamic> toJson() => {
        "id_paciente": idPaciente,
        "p_nombre": pNombre,
        "p_apellido": pApellido,
    };
}