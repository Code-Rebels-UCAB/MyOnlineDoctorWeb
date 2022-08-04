import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/registro_medico/infraestructura/modelo/registroMedico.dart';

popUpRegistro(BuildContext context, String mensaje, RegistroMedico registro) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(mensaje)),
          content: SizedBox(
            height: 600,
            width: 400,
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
                          'Motivo: ${registro.motivo}',
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Modalidad: ${registro.modalidad}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Historia: ${registro.historia}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Diagnostico: ${registro.diagnostico}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Plan: ${registro.plan}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Examenes: ${registro.examenes}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        Text(
                          'Prescripcion: ${registro.prescripcion}',
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
                      children: [
                        SizedBox(
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
