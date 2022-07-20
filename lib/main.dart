import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/providers/cita_estado.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/Index.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/videollamada/servicio/iniciar_cita_servicio.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> CitaEstado(request: IniciarLlamadaRequest()))
        ],
        child: const MyApp()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const IndexPage(),
    );
  }
}


