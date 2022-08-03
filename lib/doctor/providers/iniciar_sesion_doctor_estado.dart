

import 'package:flutter/cupertino.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/puertos/doctor_servicio_abstract.dart';

import '../infraestructura/modelos/IniciarSesionDoctorModelo.dart';

class IniciarSesionEstado with ChangeNotifier {

  final DoctorServicioAbstract request;

  IniciarSesionEstado(this.request);

  Future<void> iniciarSesion(IniciarSesionDoctorModelo credenciales) async{
    try{
      print('pase');
      final response = await request.iniciarSesionDoctorRequest(credenciales);
      print(response);
      notifyListeners();
    }catch(e){
      print('no pase');
      throw Exception("Algo Salio mal");
    }
  }


}
