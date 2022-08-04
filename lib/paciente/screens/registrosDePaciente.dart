import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/servicios/citas_api.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/campo_citas.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/popUpDone.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedStream.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedico.dart';
import 'package:myonlinedoctorweb/registro_medico/screens/popUpRegistro.dart';

class todasregistrosLista extends StatefulWidget {
  String idPaciente;

  todasregistrosLista({Key? key, required this.idPaciente}) : super(key: key);

  @override
  State<todasregistrosLista> createState() => _todasregistrosListaState();
}

class _todasregistrosListaState extends State<todasregistrosLista> {
  // Future<List<Cita>?> citasApi = ServiceCitaApi.getTodasCitas();
  dynamic listRegistros;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openCitaStream();
  }

  void openCitaStream() {
    setState(() => listRegistros =
        RegistroMedStream.streamTodasRegistros(widget.idPaciente));
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
        child: buildRegistros(),
      ),
    );
  }

  Widget buildRegistros() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
          child: Align(
            alignment: Alignment.center,
            child: Text("Todas los registros", style: TextStyle(fontSize: 28)),
          ),
        ),
        StreamBuilder(
          stream: listRegistros,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.none:
                  return const Center(child: Text('NONE'));
                case ConnectionState.active:
                case ConnectionState.done:
                  return _ListaDeRegistros(snapshot.data);
              }
            } else {
              return const Center(child: Text('SERVIDOR CAIDO'));
            }
          },
        )
      ],
    );
  }

  Widget _ListaDeRegistros(dynamic data) {
    return Expanded(
        child: data.length >= 1
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final registro = data[index];
                  return Card(
                      child: Container(
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CampoCita(dato: registro.nombreDoctor, size: 200.0),
                        CampoCita(dato: registro.modalidad, size: 200.0),
                        CampoCita(dato: registro.fechaCita, size: 200.0),
                        _mostrarBotones(registro)
                      ],
                    ),
                  ));
                },
              )
            : const Center(child: Text('NO HAY CITAS ACTUALMENTE')));
  }

  Widget _mostrarBotones(RegistroMedico registro) {
    return Row(
      children: [
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 77, 72, 229),
              ),
              child: const Text(
                'Ver Detalles',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {
                popUpRegistro(context, '', registro);
              }),
        ),
        const SizedBox(
          width: 30.0,
        ),
        SizedBox(
          height: 50.0,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 232, 107, 18),
              ),
              child: const Text(
                'editar',
                style: TextStyle(fontSize: 22),
              ),
              onPressed: () {}),
        ),
      ],
    );
  }
}
