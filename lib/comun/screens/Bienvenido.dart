import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';


class Bienvenido extends StatelessWidget {
  const Bienvenido({Key? key}) : super(key: key);

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
        child: Column(
          children: [
            Container(
              child: const Text(
                'Bienvenido Doctor Bueno',
                style: TextStyle(fontSize: 40.0),
              ),
              padding: const EdgeInsets.only(top: 50.0),
            ),
            Center(
              child: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/doc.jpg',
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                radius: 70,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  Container(
                    child: const Text(
                      'Total Pacientes: 30',
                      style: TextStyle(fontSize: 40.0),
                    ),
                    padding: const EdgeInsets.fromLTRB(70.0, 70.0, 0, 0),
                    alignment: Alignment.topCenter,
                  ),
                  Container(
                    child: const Text(
                      'Total Pacientes del Sistema: 200',
                      style: TextStyle(fontSize: 40.0),
                    ),
                    padding: const EdgeInsets.fromLTRB(70.0, 20.0, 0, 0),
                    alignment: Alignment.topCenter,
                  ),
                  Container(
                    child: const Text(
                      'Citas de Hoy: 20',
                      style: TextStyle(fontSize: 40.0),
                    ),
                    padding: const EdgeInsets.fromLTRB(70.0, 20.0, 0, 0),
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
