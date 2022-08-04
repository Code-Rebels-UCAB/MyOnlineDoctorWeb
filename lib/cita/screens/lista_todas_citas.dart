import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/modelo/CitaStream.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/campo_citas.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/popUpDone.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';

import '../infraestructura/modelo/Cita.dart';

class todasCitasLista extends StatefulWidget {
  todasCitasLista({
    Key? key,
  }) : super(key: key);

  @override
  State<todasCitasLista> createState() => _todasCitasListaState();
}

class _todasCitasListaState extends State<todasCitasLista> {
  // Future<List<Cita>?> citasApi = ServiceCitaApi.getTodasCitas();
  late Stream<List<Cita>?> listCitas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openCitaStream();
  }

  void openCitaStream() {
    setState(() => listCitas = CitaStream.streamTodasCitas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyOnlineDoctor'),
        backgroundColor: const Color(0xFF00B0E8),
      ),
      body: Container(
        child: buildCitas(),
      ),
    );
  }

  Widget buildCitas() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text("Todas las citas", style: TextStyle(fontSize: 28)),
          ),
        ),
        StreamBuilder(
          stream: listCitas,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                  return const Center(child: Text('NONE'));
                case ConnectionState.active:
                case ConnectionState.done:
                  return _ListaDeCitas(snapshot.data);
              }
            } else {
              return const Center(child: Text('SERVIDOR CAIDO'));
            }
          },
        )
      ],
    );
  }

  Widget _ListaDeCitas(dynamic data) {
    return Expanded(
        child: data.length >= 1
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final cita = data[index];
                  return Card(
                      child: Container(
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CampoCita(
                              dato: cita.paciente.pNombre +
                                  ' ' +
                                  cita.paciente.pApellido,
                              size: 300.0),
                        ),
                        Expanded(
                            child:
                                CampoCita(dato: cita.fechacita, size: 300.0)),
                        Expanded(
                            child: CampoCita(dato: cita.horacita, size: 300.0)),
                        Expanded(
                            child:
                                CampoCita(dato: cita.modalidad, size: 300.0)),
                        Expanded(
                            child:
                                CampoCita(dato: cita.statuscita, size: 300.0)),
                        if (cita.statuscita == "Aceptada")
                          _mostrarBotones(cita.idCita)
                      ],
                    ),
                  ));
                },
              )
            : const Center(child: Text('NO HAY CITAS ACTUALMENTE')));
  }

  Widget _mostrarBotones(String idCita) {
    return Row(
      children: [
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 0, 0),
              ),
              child: const Text(
                'Suspender',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {
                ServiceCitaApi.suspenderCita(idCita);
                popUpDone(context, "Cita suspendida exitosamente");
                openCitaStream();
              }),
        ),
      ],
    );
  }
}
