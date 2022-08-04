
class IniciarSesionDoctorModelo {
  final String correoDoctor;
  final String passwordDoctor;

  const IniciarSesionDoctorModelo({
    required this.correoDoctor,
    required this.passwordDoctor,
  });

  factory IniciarSesionDoctorModelo.fromJson(Map<String, dynamic> json){
    return IniciarSesionDoctorModelo(
      correoDoctor: json['correo'],
      passwordDoctor: json['password'],
    );
  }

}