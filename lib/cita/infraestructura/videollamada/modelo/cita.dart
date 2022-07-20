
import 'package:myonlinedoctorweb/cita/infraestructura/videollamada/modelo/videollamada.dart';

class Cita {
    final String idCita;
    final String idPaciente;
    final String idDoctor;
    final String status;
    final String modalidad;
    final String motivo;
    final fechaCita;
    final  horaCita;
    final  duracion;
    final VideollamadaCita videollamada;

    const Cita({
      required this.idCita,
      required this.idPaciente,
      required this.idDoctor,
      required this.status,
      required this.modalidad,
      required this.motivo,
      required this.fechaCita,
      required this.horaCita,
      required this.duracion,
      required this.videollamada,

  });

    factory Cita.fromJson(Map<String, dynamic> json){
      return Cita(
          idCita: json['idCita'],
          idPaciente: json['idPaciente'],
          idDoctor: json['idDoctor'],
          status: json['status'],
          modalidad: json['modalidad'],
          motivo: json['motivo'],
          fechaCita: json['fechaCita'],
          horaCita: json['horaCita'],
          duracion: json['duracion'],
          videollamada: VideollamadaCita(
              nombreCanal: json['videollamada']['nombreCanal'],
              tokenTemp: json['videollamada']['tokenTemp']
          )
      );

    }

}