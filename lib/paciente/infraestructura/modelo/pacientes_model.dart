class PacienteModel {
  final String idPaciente;
  final String p_nombre;
  final String s_nombre;
  final String p_apellido;
  final String s_apellido;
  final String sexo;
  final String altura;
  final String peso;
  final String telefono;
  final String antecedentes;
  final String operacion;
  final String status_suscripcion;
  final String alergia;
  final String correo;
  final dynamic fecha_nacimiento;

  PacienteModel({
    required this.idPaciente,
    required this.p_nombre,
    required this.s_nombre,
    required this.p_apellido,
    required this.s_apellido,
    required this.sexo,
    required this.altura,
    required this.peso,
    required this.telefono,
    required this.antecedentes,
    required this.operacion,
    required this.status_suscripcion,
    required this.alergia,
    required this.correo,
    required this.fecha_nacimiento,
  });

  PacienteModel.fromJson(Map<String, dynamic> parsedJson)
      : idPaciente = parsedJson['id_paciente'],
        p_nombre = parsedJson['p_nombre'],
        s_nombre = parsedJson['s_nombre'],
        p_apellido = parsedJson['p_apellido'],
        s_apellido = parsedJson['s_apellido'],
        sexo = parsedJson['sexo'],
        altura = parsedJson['altura'],
        peso = parsedJson['peso'],
        telefono = parsedJson['telefono'],
        antecedentes = parsedJson['antecedentes'],
        operacion = parsedJson['operacion'],
        status_suscripcion = parsedJson['status_suscripcion'],
        alergia = parsedJson['alergia'],
        correo = parsedJson['correo'],
        fecha_nacimiento = parsedJson['fecha_nacimiento'];
}
