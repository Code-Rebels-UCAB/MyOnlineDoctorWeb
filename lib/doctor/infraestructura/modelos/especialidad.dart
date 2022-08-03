

class Especialidad {
  final String nombre;

  Especialidad({
    required this.nombre
  });

  factory Especialidad.fromJson(Map<String, dynamic> json) {
    return Especialidad(
        nombre: json['nombre']);
  }

  @override
  String toString() {
    return nombre;
  }
}