import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/providers/cita_estado.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/videollamada/servicio/videollamada_cita_servicio.dart';
import 'package:myonlinedoctorweb/doctor/screens/inciar_sesi%C3%B3n_doctor.dart';
import 'package:myonlinedoctorweb/registro_medico/provider/MedicalProvider.dart';
import 'package:provider/provider.dart';
import 'package:myonlinedoctorweb/comun/screens/Bienvenido.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> CitaEstado(request: LlamadaRequest())),
          Provider(create: (context) => MedicalRecordProvider()),
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
