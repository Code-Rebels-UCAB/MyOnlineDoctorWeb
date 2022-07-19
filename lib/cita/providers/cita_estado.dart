
import 'package:flutter/cupertino.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/cita_request_abstract.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/videollamada_cita.dart';

class CitaEstado with ChangeNotifier {

  VideollamadaCita? _cita;
  CitaRequestAbstract request;
  CitaEstado({required this.request});

  VideollamadaCita? get cita {
    if(_cita != null){
      return _cita;
    }
    return null;
  }

  Future<void> obtenerCitasDesdApi(String citaid) async {
    try{
      _cita = await request.obtenerDataVideollamada(citaid);
      notifyListeners();
    }catch(e){
      throw Exception('Algo salio mal');
    }
  }
}