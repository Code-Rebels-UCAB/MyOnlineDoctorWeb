import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacientes_model.dart';

class DataPaciente extends StatefulWidget {
  PacienteModel pacienT;

  DataPaciente({Key? key, required this.pacienT}) : super(key: key);
  @override
  State<DataPaciente> createState() => _DataPacienteState();
}

class _DataPacienteState extends State<DataPaciente> {
  @override
  Widget build(BuildContext context) {
    PacienteModel paciente = widget.pacienT;
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            centerTitle: true,
            title: const Text('MyOnlineDoctor'),
            backgroundColor: const Color(0xFF00B0E8),
          ),
          body: Center(
            child: SizedBox(
              width: 500,
              height: 600,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 30.0),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre: ${paciente.p_nombre! + ' ' + paciente.s_nombre! + ' ' + paciente.p_apellido! + ' ' + paciente.s_apellido!}',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Telefono: ${paciente.telefono}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            paciente.sexo == 'M'
                                ? "Sexo: Masculino"
                                : "Sexo: Femenino",
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Fecha de Naciemiento: ${paciente.fecha_nacimiento}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Altura: ${paciente.altura}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Peso: ${paciente.peso}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Antecedentes: ${paciente.antecedentes}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Operaciones: ${paciente.operacion}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Alergias: ${paciente.alergia}',
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 160.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [_mostrarBoton()],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _mostrarBoton() {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 59, 149, 227),
          ),
          child: const Text(
            'Volver',
            style: TextStyle(fontSize: 22),
          ),
          onPressed: () {
            Navigator.pop(context, true);
          }),
    );
  }
}
