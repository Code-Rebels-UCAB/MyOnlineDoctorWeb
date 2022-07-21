
import 'package:flutter/cupertino.dart';

import '../infraestructura/puertos/cita_request_abstract.dart';
import '../infraestructura/videollamada/modelo/cita_iniciada.dart';


class CitaEstado with ChangeNotifier {

  CitaIniciada? _cita;
  CitaRequestAbstract request;
  CitaEstado({required this.request});

  CitaIniciada? get cita {
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

  Future<void> enviarCitaDesdeFront(String citaid) async {
    try{
      await request.enviarDataVideollamadaFinalizada(citaid);
      notifyListeners();
    }catch(e){
      throw Exception('Algo salio mal');
    }
  }
}