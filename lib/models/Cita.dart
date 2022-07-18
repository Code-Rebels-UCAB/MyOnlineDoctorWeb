import 'package:flutter/cupertino.dart';

class Cita with ChangeNotifier {
  final String Paciente;
  final String Date;
  final String Hour;
  final String Modalidad;
  late final String Status;

  Cita({
    required this.Paciente,
    required this.Date,
    required this.Hour, 
    required this.Modalidad,
    required this.Status,
  });

  void changeStatus(String stat) {
    Status = stat;
  }

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      Paciente: json['Paciente'],
      Date: json['Date'],
      Hour: json['Hour'],
      Modalidad: json['Modalidad'],
      Status: json['Status'],
    );
  }
}
