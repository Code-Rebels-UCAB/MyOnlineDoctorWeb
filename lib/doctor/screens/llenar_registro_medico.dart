import 'dart:html';

import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/doctor/screens/campo_registro.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedico.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/servicios/serviceRegistro.dart';
import 'package:myonlinedoctorweb/registro_medico/provider/MedicalProvider.dart';
import 'package:provider/provider.dart';

class RegistroMedicoView extends StatelessWidget {
  late List<String> listData = [];

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
                      CampoRegistro(header: "Diagnostico", listData: listData),
                      CampoRegistro(header: "Plan", listData: listData),
                      CampoRegistro(header: "Historia", listData: listData),
                      CampoRegistro(
                          header: "Exámenes a realizar", listData: listData),
                      CampoRegistro(
                          header: "Preinscripcion", listData: listData),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    formKey.currentState!.validate();

                                if (isValid) {
                                  formKey.currentState!.save();
                                  RegistroMedico registroNuevo = RegistroMedico(
                                    diagnostico: listData[0],
                                    plan: listData[1],
                                    historia: listData[2],
                                    examenes: listData[3],
                                    prescripcion: listData[4],
                                    idCita: Provider.of<MedicalRecordProvider>(
                                            context,
                                            listen: false)
                                        .idCita,
                                    idDoctor:
                                        Provider.of<MedicalRecordProvider>(
                                                context,
                                                listen: false)
                                            .idDoctor,
                                  );
                                  ServiceRegistroMedico.crearRegistroMed(
                                      registroNuevo);
                                }
                                Navigator.pop(context, true);
                              },
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
