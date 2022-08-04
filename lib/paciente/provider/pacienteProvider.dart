import 'package:myonlinedoctorweb/paciente/infraestructura/Paciente.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacientes_model.dart';

class PacienteProvider {
  late PacienteModel paciente;
  void setPacienteProvider(PacienteModel pac) {
    paciente = pac;
  }
}

// class PacienteProvider {
//   late String? idPaciente;
//   late String? p_nombre;
//   late String? s_nombre;
//   late String? p_apellido;
//   late String? s_apellido;
//   late String? sexo;
//   late String? altura;
//   late String? peso;
//   late String? telefono;
//   late String? antecedentes;
//   late String? operacion;
//   late String? status_suscripcion;
//   late String? alergia;
//   late String? correo;
//   late dynamic? fecha_nacimiento;

//   void setPacienteProvider(
//     String idPaciente,
//     String p_nombre,
//     String s_nombre,
//     String p_apellido,
//     String s_apellido,
//     String sexo,
//     String altura,
//     String peso,
//     String telefono,
//     String antecedentes,
//     String operacion,
//     String status_suscripcion,
//     String alergia,
//     String correo,
//     String fecha_nacimiento,
//   ) {
//     idPaciente = idPaciente;
//     p_nombre = p_nombre;
//     s_nombre = s_nombre;
//     p_apellido = p_apellido;
//     s_apellido = s_apellido;
//     sexo = sexo;
//     altura = altura;
//     peso = peso;
//     telefono = telefono;
//     antecedentes = antecedentes;
//     operacion = operacion;
//     status_suscripcion = status_suscripcion;
//     alergia = alergia;
//     correo = correo;
//     fecha_nacimiento = fecha_nacimiento;
//   }
// }
