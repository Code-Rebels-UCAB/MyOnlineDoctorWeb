import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/campo_citas.dart';
import '../../comun/screens/NavBar.dart';
import '../infraestructura/servicios/solicitudes_cita_api.dart';

class citasSolicitadasLista extends StatefulWidget {
  @override
  State<citasSolicitadasLista> createState() => _citasSolicitadasListaState();
}

class _citasSolicitadasListaState extends State<citasSolicitadasLista> {
  DateTime? date = DateTime.now();
  TimeOfDay? time =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  late String citaAct;
  bool isErrorDate = false;
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
        child: buildCitas(DateTime.now()),
      ),
    );
  }

  Widget buildCitas(DateTime fechaHoy) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text("Solicitudes", style: TextStyle(fontSize: 28)),
          ),
        ),
        FutureBuilder(
          future: ServiceCitaSolicitud.getCitasSolicitadas(),
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
                                  cita.paciente.pApellido),
                        ),
                        Expanded(child: CampoCita(dato: cita.motivo)),
                        Expanded(child: CampoCita(dato: cita.modalidad)),
                        Expanded(child: CampoCita(dato: cita.statuscita)),
                        _mostrarBotones(cita, cita.idCita)
                      ],
                    ),
                  ));
                },
              )
            : const Center(child: Text('NO HAY SOLICITUDES ACTUALMENTE')));
  }

  Widget _mostrarBotones(dynamic cita, String idCita) {
    return Row(
      children: [
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 15, 214, 18),
              ),
              child: const Text(
                'Aceptar',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {
                _PopUp(context, cita, date);
                setState(() {
                  citaAct = idCita;
                });
              }),
        ),
      ],
    );
  }

  _PopUp(BuildContext context, dynamic cita, DateTime? date) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Center(
                    child: Text('Paciente:  ' +
                        cita.paciente.pNombre +
                        ' ' +
                        cita.paciente.pApellido)),
                content: Container(
                  height: 250,
                  width: 500,
                  child: Expanded(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Fecha: ',
                            ),
                            SizedBox(
                              width: 200,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              '${date != null ? date!.year : 'none'} / ${date != null ? date!.month : 'none'} / ${date != null ? date!.day : 'none'}'),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF00B0E8),
                                ),
                                child: const Text(
                                  'Seleccionar Fecha',
                                  style: TextStyle(fontSize: 14),
                                ),
                                onPressed: () async {
                                  DateTime? newDate = await showDatePicker(
                                      context: context,
                                      initialDate: date!,
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2023));
                                  setState(() {
                                    if (newDate != null &&
                                        date!.isAfter(DateTime.now())) {
                                      date = newDate;
                                      isErrorDate = false;
                                    } else {
                                      date = DateTime.now();
                                      isErrorDate = true;
                                    }
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Hora:  '),
                            SizedBox(
                              width: 200,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                          '${time!.hour}:${(time!.minute < 10) ? '0' + time!.minute.toString() : time!.minute}'),
                                    ],
                                  )),
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xFF00B0E8),
                                ),
                                child: const Text(
                                  'Seleccionar hora',
                                  style: TextStyle(fontSize: 14),
                                ),
                                onPressed: () async {
                                  TimeOfDay? newTime = await showTimePicker(
                                      context: context, initialTime: time!);
                                  setState(() {
                                    if (newTime != null) time = newTime;
                                  });
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        if (isErrorDate == true)
                          const Text(
                              'Fecha Invalida [Selecciona una fecha despues de hoy]',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 16))
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Center(
                      child: SizedBox(
                        height: 30,
                        width: 150,
                        child: MaterialButton(
                          color: const Color(0xFF00B0E8),
                          elevation: 5.0,
                          child: const Text(
                            'Agendar Cita',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            ServiceCitaApi.agendarCita(citaAct, date.toString(),
                                '${time!.hour}:${time!.minute}');
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }
}
