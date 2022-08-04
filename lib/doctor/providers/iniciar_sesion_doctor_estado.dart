

import 'package:flutter/cupertino.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/puertos/doctor_servicio_abstract.dart';

import '../infraestructura/modelos/IniciarSesionDoctorModelo.dart';

class IniciarSesionEstado with ChangeNotifier {

  final DoctorServicioAbstract request;

  IniciarSesionEstado(this.request);

  Future<void> iniciarSesion(IniciarSesionDoctorModelo credenciales) async{
    try{
      final response = await request.iniciarSesionDoctorRequest(credenciales);
      notifyListeners();
    }catch(e){
      throw Exception("Algo Salio mal");
    }
  }


}
