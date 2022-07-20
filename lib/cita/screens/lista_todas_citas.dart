import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/api/citasApi.dart';
import 'package:myonlinedoctorweb/cita/screens/campo_citas.dart';
import 'package:myonlinedoctorweb/common/NavBar.dart';

import '../../cita/infraestructura/Cita.dart';

class todasCitasLista extends StatefulWidget {
  todasCitasLista({
    Key? key,
  }) : super(key: key);

  @override
  State<todasCitasLista> createState() => _todasCitasListaState();
}

class _todasCitasListaState extends State<todasCitasLista> {
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
            child: Text("Todas las citas", style: TextStyle(fontSize: 28)),
          ),
        ),
        FutureBuilder(
          future: ServiceCitaApi.getTodasCitas(),
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
              CampoCita(dato: cita.fechacita),
              CampoCita(dato: cita.horacita),
              CampoCita(dato: cita.modalidad),
              CampoCita(dato: cita.statuscita),
              if (data[index].statuscita == "Aceptada") _mostrarBotones()
            ],
          ),
        ));
      },
    ));
  }

  Widget _mostrarBotones() {
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
              onPressed: () {}),
        ),
      ],
    );
  }
}
