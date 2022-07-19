import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/api/citasApi.dart';

import '../../models/Cita.dart';
import '../NavBar.dart';
import '../../JsonDataExample/data.dart';

class citasLista extends StatefulWidget {
  late int citapage;

  citasLista({Key? key, required this.citapage}) : super(key: key);

  @override
  State<citasLista> createState() => _citasListaState();
}

class _citasListaState extends State<citasLista> {
  late List<Cita> citas = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  Future init() async {
    final _citas = await ServiceCitaApi.getCitas();

    setState(() {
      if (citas != null) {
        citas = _citas!;
      } else {
        citas = [];
      }
    });
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
        child: buildCitas(citas, DateTime.now()),
      ),
    );
  }

  Widget buildCitas(List<Cita> citas, DateTime fechaHoy) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.citapage == 0
            ? SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Citas del dia de Hoy: ${DateTime.now().year} / ${DateTime.now().month} / ${DateTime.now().day}",
                      style: const TextStyle(fontSize: 28)),
                ),
              )
            : const SizedBox(
                height: 100,
                child: Align(
                  alignment: Alignment.center,
                  child:
                      Text("Todas las citas", style: TextStyle(fontSize: 28)),
                ),
              ),
        Expanded(
            child: ListView.builder(
          itemCount: citas.length,
          itemBuilder: (context, index) {
            final cita = citas[index];
            return Card(
                child: Container(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300.0,
                    child: Title(
                        color: Colors.black,
                        child: Text(
                          cita.paciente.pNombre + ' ' + cita.paciente.pApellido,
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Title(
                        color: Colors.black,
                        child: Text(
                          cita.horacita,
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Title(
                        color: Colors.black,
                        child: Text(
                          cita.modalidad,
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                  SizedBox(
                    width: 300.0,
                    child: Title(
                        color: Colors.black,
                        child: Text(
                          cita.statuscita,
                          style: const TextStyle(fontSize: 16),
                        )),
                  ),
                  if (citas[index].statuscita == "Aceptada" &&
                      widget.citapage == 0)
                    _mostrarBotones0(),
                  if (citas[index].statuscita == "Aceptada" &&
                      widget.citapage == 1)
                    _mostrarBotones1()
                ],
              ),
            ));
          },
        ))
      ],
    );
  }

  Widget _mostrarBotones0() {
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
              onPressed: () {}),
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

  Widget _mostrarBotones1() {
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
