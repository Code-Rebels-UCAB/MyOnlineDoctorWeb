import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/providers/cita_estado.dart';
import 'package:myonlinedoctorweb/comun/infraestructura/Index.dart';
import 'package:myonlinedoctorweb/cita/infraestructura/videollamada/servicio/iniciar_cita_servicio.dart';
import 'package:provider/provider.dart';
import 'package:myonlinedoctorweb/comun/screens/Bienvenido.dart';


void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> CitaEstado(request: IniciarLlamadaRequest()))
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
      initialRoute: 'home',
      routes: {
        'home': (context) => const Bienvenido(),
      },
    );
  }
}
