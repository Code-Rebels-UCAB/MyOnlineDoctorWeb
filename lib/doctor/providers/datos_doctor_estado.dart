

import 'package:flutter/cupertino.dart';

import '../infraestructura/modelos/datos_doctor.dart';
import '../infraestructura/puertos/doctor_servicio_abstract.dart';

class DatosDoctorEstado with ChangeNotifier {
  DatosDoctorModelo? doctor ;
  final DoctorServicioAbstract request;

  DatosDoctorEstado(this.request);

  Future<void> datosDoctorPerfil() async{
    try{
      final response = await request.obtenerDatosDoctorPerfil();
      doctor = response;
      notifyListeners();
    }catch(e){
      throw Exception("Algo Salio mal");
    }
  }
}