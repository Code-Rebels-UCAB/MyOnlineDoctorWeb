import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/screens/citas_dashboard.dart';
import 'package:myonlinedoctorweb/common/Bienvenido.dart';


class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var largo = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF94C6F2)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/doc.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            accountName: const Text(
              'Doctor Bueno',
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: const Text('unBuenDoctor@gmail.com',
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
            onTap: () {},
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
            onTap: () {},
          ),
          ListTile(
            leading:
                const Icon(Icons.add_alert_rounded, color: Color(0xFF94C6F2)),
            title: const Text('Solicitudes',
                style: TextStyle(color: Color(0xFF94C6F2))),
            onTap: () {},
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
