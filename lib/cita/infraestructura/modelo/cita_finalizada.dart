
class CitaFinalizada {

  final String idCita;
//  final String idPaciente;
//  final String idDoctor;
//  final String status;
//  final String modalidad;
//  final  motivo;
//  final fechacita;
//  final  horacita;
//  final  duracion;


  CitaFinalizada({
    required this.idCita,
  //  required this.idPaciente,
  //  required this.idDoctor,
  //  required this.status,
  //  required this.modalidad,
  //  required this.motivo,
  //  required this.fechacita,
  //  required this.horacita,
  //  required this.duracion,

  });

  factory CitaFinalizada.fromJson(Map<String, dynamic> json) => CitaFinalizada(
    idCita: json["id_cita"],
  //  idPaciente: json["id_paciente"],
  //  idDoctor: json["id_doctor"],
  //  status: json["status"],
  //  modalidad: json["modalidad"],
  //  motivo: json["motivo"],
  //  fechacita: json["fechacita"],
  //  horacita: json["horacita"],
  //  duracion: json["duracion"],

  );
}
