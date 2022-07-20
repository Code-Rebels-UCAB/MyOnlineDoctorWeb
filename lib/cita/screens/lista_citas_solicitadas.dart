import 'package:flutter/material.dart';
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
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.none:
                return const Center(child: Text('NONE'));
              case ConnectionState.active:
              case ConnectionState.done:
                return _ListaDeCitas(snapshot.data);
            }
          },
        )
      ],
    );
  }

  Widget _ListaDeCitas(dynamic data) {
    return Expanded(
        child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final cita = data[index];
        return Card(
            child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CampoCita(
                  dato: cita.paciente.pNombre + ' ' + cita.paciente.pApellido),
              CampoCita(dato: cita.motivo),
              CampoCita(dato: cita.modalidad),
              CampoCita(dato: cita.statuscita),
              _mostrarBotones(cita)
            ],
          ),
        ));
      },
    ));
  }

  Widget _mostrarBotones(dynamic cita) {
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
              }),
        ),
        const SizedBox(
          width: 50.0,
        ),
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFF0000),
              ),
              child: const Text(
                'Rechazar',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {}),
        )
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
                  height: 150,
                  width: 500,
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
                                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: Text(
                                    '${date != null ? date!.year : 'none'} / ${date != null ? date!.month : 'none'} / ${date != null ? date!.day : 'none'}')),
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

                                if (date == null) return;
                                setState(() {
                                  date = newDate;
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
                                padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                child: Text('${time!.hour}:${time!.minute}')),
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

                                if (date == null) return;
                                setState(() {
                                  time = newTime;
                                });
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Center(
                      child: SizedBox(
                        width: 150,
                        child: MaterialButton(
                          color: const Color(0xFF00B0E8),
                          elevation: 5.0,
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
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
