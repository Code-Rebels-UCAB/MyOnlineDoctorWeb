import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/campo_citas.dart';
import 'package:myonlinedoctorweb/cita/screens/videollamada/Llamada.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:provider/provider.dart';
import '../../comun/infraestructura/error_dialogo.dart';
import '../providers/cita_estado.dart';

class citasDiaLista extends StatefulWidget {
  citasDiaLista({
    Key? key,
  }) : super(key: key);

  @override
  State<citasDiaLista> createState() => _citasDiaListaState();
}

class _citasDiaListaState extends State<citasDiaLista> {

  bool _estaCargando = false;

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
        SizedBox(
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text(
                "Citas del dia de Hoy: ${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}",
                style: TextStyle(fontSize: 28)),
          ),
        ),
        FutureBuilder(
          future: ServiceCitaApi.getCitasDia(),
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
              CampoCita(dato: cita.horacita),
              CampoCita(dato: cita.modalidad),
              CampoCita(dato: cita.statuscita),
              if (cita.statuscita == "Aceptada") _mostrarBotones(cita.idCita)
            ],
          ),
        ));
      },
    ));
  }

  Widget _mostrarBotones(String citaId) {
    return Row(
      children: [
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 15, 214, 18),
              ),
              child: const Text(
                'Llamar',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {if (citaId!=null){onJoin(citaId);} }),
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
                'Cancelar',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {}),
        )
      ],
    );
  }

  Future<void> onJoin(String citaid) async {
    print(citaid);
    setState(() {
      _estaCargando = true;
    });
    await window.navigator.getUserMedia(audio: true, video: true);
    try {
      await Provider.of<CitaEstado>(context, listen: false).obtenerCitasDesdApi(citaid);
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CallPage(),
          )
      );
    }catch(e){
      ErrorDialog.showErrorDialog(e.toString(), context);
    }finally{
      setState(() {
        _estaCargando = false;
      });
    }


  }
}
