import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/providers/cita_estado.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/videollamada/servicio/videollamada_cita_servicio.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/auth_service.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/puertos/auth_service_abstract.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/autenticacion/storage/guardado_token_jwt.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/servicios/iniciar_sesion_doctor_servicio.dart';
import 'package:myonlinedoctorweb/doctor/screens/inciar_sesi%C3%B3n_doctor.dart';
import 'package:provider/provider.dart';
import 'package:myonlinedoctorweb/comun/screens/Bienvenido.dart';

import 'doctor/providers/iniciar_sesion_doctor_estado.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> CitaEstado(request: LlamadaRequest())),
          ChangeNotifierProvider(create: (_) => IniciarSesionEstado(IniciarSesionDoctorServicio(AuthService(authToken: GuardadoTokenJwt() ))))
        ],
        child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: 'iniciarsesion',
      routes: {
        'iniciarsesion': (context) => IniciarSesion(),
      },
    );
  }
}
