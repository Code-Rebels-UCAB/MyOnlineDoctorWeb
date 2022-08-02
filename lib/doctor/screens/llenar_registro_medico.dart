import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/doctor/screens/campo_registro.dart';

class RegistroMedico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('MyOnlineDoctor'),
          backgroundColor: const Color(0xFF00B0E8),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  const Text('Registro Medico',
                      style: TextStyle(fontSize: 28.0)),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 35)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "Fecha: ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}",
                            style: const TextStyle(fontSize: 18.0)),
                        const Text("Doctor: Pedro Perez",
                            style: TextStyle(fontSize: 18.0)),
                        const Text("Paciente: Carlos Arriaga",
                            style: TextStyle(fontSize: 18.0)),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                  Column(
                    children: [
                      CampoRegistro(header: "Diagnostico"),
                      CampoRegistro(header: "Plan"),
                      CampoRegistro(header: "Historia"),
                      CampoRegistro(header: "Exámenes a realizar"),
                      CampoRegistro(header: "Preinscripcion"),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Crear Registro Medico')),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
