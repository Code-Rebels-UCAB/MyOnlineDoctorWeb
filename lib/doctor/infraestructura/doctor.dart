class Doctor {
    Doctor({
        required this.idDoctor,
        required this.pNombre,
        required this.pApellido,
    });

    String idDoctor;
    String pNombre;
    String pApellido;

    factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        idDoctor: json["id_doctor"],
        pNombre: json["p_nombre"],
        pApellido: json["p_apellido"],
    );

    Map<String, dynamic> toJson() => {
        "id_doctor": idDoctor,
        "p_nombre": pNombre,
        "p_apellido": pApellido,
    };
}
