import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/campo_citas.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/popUpDone.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacienteStream.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacientes_model.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/servicios/paciente_service.dart';
import 'package:myonlinedoctorweb/paciente/provider/pacienteProvider.dart';
import 'package:myonlinedoctorweb/paciente/screens/registrosDePaciente.dart';
import 'package:myonlinedoctorweb/paciente/screens/verDataPaciente.dart';
import 'package:myonlinedoctorweb/paciente/screens/widgets/campo_pacientes.dart';
import 'package:provider/provider.dart';

class SearchPacienteScreen extends StatefulWidget {
  const SearchPacienteScreen({Key? key}) : super(key: key);
  @override
  State<SearchPacienteScreen> createState() => _SearchPacienteScreenState();
}

class _SearchPacienteScreenState extends State<SearchPacienteScreen> {
  PacienteService pacienteService = PacienteService();
  dynamic listOfPacientes;
  // ignore: prefer_final_fields
  TextEditingController _textFieldFilter = TextEditingController();
  dynamic _dropdownSelectedFilterItem = ' ';
  dynamic dropdownFlag = 0;
  dynamic _searchBarEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openPacienteStream(_dropdownSelectedFilterItem, _textFieldFilter.text);
  }

  void openPacienteStream(String dropdown, String texto) {
    setState(() =>
        listOfPacientes = PacienteStream.streamTodosPacientes(dropdown, texto));
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
        // FutureBuilde para la carga de dostores
        body: StreamBuilder(
          // Para obtener el futuro de uns busqueda, enviamos el filtro y el valor que desea el usuario de ese filtro
          stream: listOfPacientes,
          //futureDoctorTask(_textFieldFilter.text, _dropdownSelectedFilterItem),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return CustomScrollView(slivers: [
              // Dropdown Button y Barra de Busqueda (TextField) para la busqueda
              SliverToBoxAdapter(
                  child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 8.0,
                      ),
                      const Text(
                        'Filtrar por: ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                          // Dropdown Button
                          child: _filterDropdown(context))
                    ]),
                // Barra de Busqueda (TextField)
                _searchBar(context),
              ])),

              // Si el estado de la conexion esta en espera
              (snapshot.connectionState == ConnectionState.waiting)

                  // Si el estado de la conexion esta en espera, genera un CircularProgressIndicator de cargo
                  ? const SliverFillRemaining(
                      child: Center(
                      child: CircularProgressIndicator(),
                    ))

                  // Si el estado de la conexion es lista
                  : (snapshot.connectionState == ConnectionState.done)
                      ? (snapshot.hasData)
                          ? (snapshot.data.isNotEmpty)

                              // Si el estado de la conexion es lista y hay data, crea el cuerpo de la pagina
                              ? _pacienteList(context, snapshot.data)

                              // Si el estado de la conexion es lista, hay data y esta vacia
                              : const SliverFillRemaining(
                                  child: Center(
                                  child: Text(
                                    'Data Vacia',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ))

                          // Si el estado de la conexion es lista y no hay data, muestra Error
                          : const SliverFillRemaining(
                              child: Center(
                              child: Text(
                                'No hay coincidencias',
                                style: TextStyle(fontSize: 18),
                              ),
                            ))

                      // Si el estado de la conexion no esta lista
                      : const SliverFillRemaining(
                          child: Center(
                              child: Text(
                            '??',
                            style: TextStyle(fontSize: 18),
                          )),
                        )
            ]);
          },
        ));
  }

  // Dropdown Button para la seleccion de filtro
  Widget _filterDropdown(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue, width: 1)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: const Text('Select'),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.blue,
          ),

          // Valor actual del Dropdown Button
          value: _dropdownSelectedFilterItem,

          // Valores para el filtro
          items: <String>[
            ' ',
            'Nombre y Apellido',
            'Telefono'
            //'Geolocalización'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          underline: const SizedBox(
            height: 0,
          ),

          // Cuando cambie el estado del Dropdown Button: asigna el nuevo valor, y habilita o deshabilita el TextField de busqueda
          onChanged: (newValue) {
            setState(() {
              _dropdownSelectedFilterItem = newValue;
              if (_dropdownSelectedFilterItem == ' ') {
                _searchBarEnable = false;
              } else {
                _searchBarEnable = true;
              }
            });
          },
        ),
      ),
    );
  }

  // TextField para la busqueda
  Widget _searchBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue, width: 1)),
      width: double.infinity,
      height: 45,
      child: TextField(
        controller: _textFieldFilter,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Buscar',
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            suffixIcon:
                /////////////////////////////////////////////////////////////////FILTRO GEOGRAFICO
                //IconButton(icon: Icon(Icons.location_on_sharp), color: Colors.blue, onPressed: () {}),
                Icon(
              Icons.location_on_sharp,
              color: Colors.blue,
            )),

        // Propiedad que habilita/deshabilita el TextField
        enabled: _searchBarEnable,

        /////////////////////////////////////////////////////////////////////////////////////////////////////////////VUELVE AQUI
        onTap: () {
          if (_dropdownSelectedFilterItem == ' ') {
            // alert
          }
        },

        // Cuando se de un cambio de estado en el TextField, reconstruye
        onChanged: (text) {
          setState(() {
            openPacienteStream(
                _dropdownSelectedFilterItem, _textFieldFilter.text);
          });
        },
      ),
    );
  }

  // Lista de doctores
  Widget _pacienteList(BuildContext context, List doctorsfuture) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Card(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListaPacientes(doctorsfuture[index])),
        ),
        childCount: doctorsfuture.length,
      ),
    );
  }

  Widget ListaPacientes(PacienteModel item) {
    Provider.of<PacienteProvider>(context, listen: false)
        .setPacienteProvider(item);
    return Container(
      // Se agrega la lista de Widgets, cada uno con la informacion de un doctor
      child: _PacienteItem(
          Provider.of<PacienteProvider>(context, listen: false).paciente),
    );
  }

  Widget _PacienteItem(PacienteModel pacienT) {
    String? sexoAux =
        pacienT.sexo == 'M' ? "Sexo: Masculino" : "Sexo: Femenino";
    return Card(
        child: Container(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CampoCita(
              dato: pacienT.p_nombre! + ' ' + pacienT.p_apellido!, size: 200.0),
          CampoCita(dato: 'Telefono:   ${pacienT.telefono}', size: 150.0),
          CampoCita(dato: 'Correo:   ${pacienT.correo}', size: 200.0),
          const SizedBox(
            width: 50.0,
          ),
          _mostrarBotones1(pacienT),
        ],
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     CampoCita(
        //       dato: p_nombre! + ' ' + p_apellido!,
        //       size: 10.0,
        //     ),
        //     CampoCita(
        //       dato: sexoAux,
        //       size: 10.0,
        //     ),
        //     CampoCita(
        //       dato: 'Correo:   $correo',
        //       size: 10.0,
        //     ),
        //     CampoCita(
        //       dato: 'Telefono:   $telefono',
        //       size: 10.0,
        //     )
        //   ],
      ),
    ));
  }

  // Verifica la cantidad de especialidades del medico

  Widget _mostrarBotones1(PacienteModel pacienT) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 15, 214, 18),
                ),
                child: const Text(
                  'Ver Informacion',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DataPaciente(
                                pacienT: pacienT,
                              )));
                }),
          ),
          const SizedBox(
            width: 30.0,
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 0, 136, 255),
                ),
                child: const Text(
                  'Ver Historia Medica',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => todasregistrosLista(
                                idPaciente: pacienT.idPaciente!,
                              )));
                }),
          ),
          const SizedBox(
            width: 30.0,
          ),
          if (pacienT.status_suscripcion == "Activo" ||
              pacienT.status_suscripcion == "Atrasado")
            mostrarBotonSuspender(pacienT),
          if (pacienT.status_suscripcion == "Suspendido")
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 30.0, 0),
              child: Text('Suspendido',
                  style: TextStyle(color: Colors.orangeAccent)),
            ),
          if (pacienT.status_suscripcion == "Activo" ||
              pacienT.status_suscripcion == "Suspendido" ||
              pacienT.status_suscripcion == "Atrasado")
            mostrarBotonBloquear(pacienT),
          if (pacienT.status_suscripcion == "Bloqueado")
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 30.0, 0),
              child:
                  Text('Bloqueado', style: TextStyle(color: Colors.redAccent)),
            ),
          if (pacienT.status_suscripcion == "Atrasado")
            const Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
              child: Text('Atrasado',
                  style: TextStyle(color: Colors.purpleAccent)),
            ),
        ],
      ),
    );
  }

  Widget mostrarBotonSuspender(PacienteModel pacienT) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 140, 0),
                ),
                child: const Text(
                  'Suspender',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  PacienteService.suspenderPaciente(pacienT.idPaciente!);
                  popUpDone(context, "Paciente suspendido Exitosamente");
                  setState(() {
                    openPacienteStream(
                        _dropdownSelectedFilterItem, _textFieldFilter.text);
                  });
                }),
          ),
          const SizedBox(
            width: 30.0,
          ),
        ],
      ),
    );
  }

  Widget mostrarBotonBloquear(PacienteModel pacienT) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFFFF0000),
                ),
                child: const Text(
                  'Bloquear',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  PacienteService.bloquearPaciente(pacienT.idPaciente!);
                  popUpDone(context, "Paciente bloqueado Exitosamente");
                  setState(() {
                    openPacienteStream(
                        _dropdownSelectedFilterItem, _textFieldFilter.text);
                  });
                }),
          ),
        ],
      ),
    );
  }
}
