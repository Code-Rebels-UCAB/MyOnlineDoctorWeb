
import 'dart:core';

import 'especialidad.dart';

class DatosDoctorModelo {
  final String nombre;
  final String sexo;
  final String foto;
  final int calificacion;
  final List<Especialidad> especialidades;


  const DatosDoctorModelo({
    required this.nombre,
    required this.sexo,
    required this.foto,
    required this.calificacion,
    required this.especialidades
  });

  factory DatosDoctorModelo.fromJson(Map<String, dynamic> json){
    return DatosDoctorModelo(
        nombre: json['nombre'],
        sexo: json['sexo'],
        foto: json['foto'],
        calificacion: int.parse( json['calificacion']),
        especialidades: json['especialidades'].map<Especialidad>((e)=> Especialidad(nombre: e)).toList()
    );
  }

}