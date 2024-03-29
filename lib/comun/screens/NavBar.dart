import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/screens/citas_dashboard.dart';
import 'package:myonlinedoctorweb/cita/screens/lista_citas_solicitadas.dart';
import 'package:myonlinedoctorweb/comun/screens/Bienvenido.dart';
import 'package:myonlinedoctorweb/doctor/providers/datos_doctor_estado.dart';
import 'package:myonlinedoctorweb/doctor/screens/busqueda_doctores_views/busqueda_doctores.dart';
import 'package:myonlinedoctorweb/doctor/screens/inciar_sesi%C3%B3n_doctor.dart';
import 'package:myonlinedoctorweb/doctor/screens/llenar_registro_medico.dart';
import 'package:provider/provider.dart';

import '../infraestructura/autenticacion/auth_service.dart';
import '../infraestructura/autenticacion/storage/guardado_token_jwt.dart';
import 'package:myonlinedoctorweb/paciente/screens/busqueda_pacientes.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var largo = MediaQuery.of(context).size.height;

    return Consumer<DatosDoctorEstado>(
        builder: (context, datosDoctor, _){
          return Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF94C6F2)),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://img.icons8.com/material/344/user-male-circle--v1.png',
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  accountName: Text(
                    datosDoctor.doctor!.nombre,
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(datosDoctor.doctor!.especialidades[0].nombre, //Se cambio porque el endpoint no trae el correo
                      style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart, color: Color(0xFF94C6F2)),
                  title: const Text('Inicio',
                      style: TextStyle(color: Color(0xFF94C6F2))),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Bienvenido()));
                  },
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: const Text('Entorno de Trabajo',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFF94C6F2),
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),
                ListTile(
                  leading: const Icon(Icons.people, color: Color(0xFF94C6F2)),
                  title: const Text('Pacientes',
                      style: TextStyle(color: Color(0xFF94C6F2))),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchPacienteScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book, color: Color(0xFF94C6F2)),
                  title:
                  const Text('Citas', style: TextStyle(color: Color(0xFF94C6F2))),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const citasDashboard()));
                  },
                ),
                ListTile(
                  leading:
                  const Icon(Icons.health_and_safety, color: Color(0xFF94C6F2)),
                  title: const Text('Doctores',
                      style: TextStyle(color: Color(0xFF94C6F2))),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchDoctorScreen()));
                  },
                ),
                ListTile(
                  leading:
                  const Icon(Icons.add_alert_rounded, color: Color(0xFF94C6F2)),
                  title: const Text('Solicitudes',
                      style: TextStyle(color: Color(0xFF94C6F2))),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => citasSolicitadasLista()));
                  },
                ),
                const Divider(
                  color: Color(0xFF94C6F2),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: const Text(
                    'Personal',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color(0xFF94C6F2),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.manage_accounts_sharp,
                      color: Color(0xFF94C6F2)),
                  title: const Text('Mi Perfil',
                      style: TextStyle(color: Color(0xFF94C6F2))),
                  onTap: () {},
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, largo / 3, 0, 0),
                  child: ListTile(
                    leading: const Icon(Icons.info, color: Color(0xFF94C6F2)),
                    title: const Text('Acerca de Nosotros',
                        style: TextStyle(
                          color: Color(0xFF94C6F2),
                        )),
                    onTap: () {},
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Color(0xFF94C6F2)),
                  title: const Text('Cerrar Sesion ',
                      style: TextStyle(
                        color: Color(0xFF94C6F2),
                      )),
                  onTap: () async {
                    await AuthService(authToken: GuardadoTokenJwt()).borrarToken();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IniciarSesion()));
                  },
                ),
              ],
            ),
          );
        }
    );
  }
}
