
import 'package:flutter/cupertino.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/cita_request_abstract.dart';

import '../infraestructura/videollamada/modelo/cita.dart';


class CitaEstado with ChangeNotifier {

  Cita? _cita;
  CitaRequestAbstract request;
  CitaEstado({required this.request});

  Cita? get cita {
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