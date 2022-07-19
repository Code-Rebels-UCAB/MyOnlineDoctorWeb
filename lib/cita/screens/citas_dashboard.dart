import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/screens/lista_citas_dia.dart';
import 'package:myonlinedoctorweb/cita/screens/lista_todas_citas.dart';
import 'package:myonlinedoctorweb/common/NavBar.dart';



class citasDashboard extends StatelessWidget {
  const citasDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyOnlineDoctor'),
        backgroundColor: const Color(0xFF00B0E8),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF00B0E8),
                  ),
                  child: const Text(
                    'Citas del Dia',
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => citasDiaLista()));
                  }),
            ),
            const SizedBox(
              width: 400.0,
            ),
            SizedBox(
              width: 200.0,
              height: 100.0,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF00B0E8),
                  ),
                  child: const Text(
                    'Todas las Citas',
                    style: TextStyle(fontSize: 22),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => todasCitasLista()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
