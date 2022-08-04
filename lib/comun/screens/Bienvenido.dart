
import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/doctor/providers/datos_doctor_estado.dart';
import 'package:provider/provider.dart';


class Bienvenido extends StatefulWidget {
  const Bienvenido({Key? key}) : super(key: key);

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {
  bool _isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies(){

    super.didChangeDependencies();
  }
  Future<void> obtenerDatosDoctor() async {
    await Provider.of<DatosDoctorEstado>(context, listen: false).datosDoctorPerfil();

  }

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
        child: FutureBuilder(
          future: obtenerDatosDoctor(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(dataSnapshot.error != null){
              return Text("Algo salio mal");
            }
            return Consumer<DatosDoctorEstado>(
              builder: (ctx, doctorEstado, _){
                return Column(
                  children: [
                    Container(
                      child: Text(
                        'Bienvenido Doctor ' + doctorEstado.doctor!.nombre,
                        style: TextStyle(fontSize: 40.0),
                      ),
                      padding: const EdgeInsets.only(top: 50.0),
                    ),
                    Center(
                      child: CircleAvatar(
                        child: ClipOval(
                          child: Image.network(
                            'https://img.icons8.com/material/344/user-male-circle--v1.png',
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
                );
              },
            );
          },
        ),
      ),
    );
  }
}
