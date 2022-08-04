import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/modelo/pacientes_model.dart';
import 'package:myonlinedoctorweb/paciente/infraestructura/servicios/paciente_service.dart';

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
    listOfPacientes = pacienteService.getPacientes(
        _dropdownSelectedFilterItem, _textFieldFilter.text);
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
        body: FutureBuilder(
          // Para obtener el futuro de uns busqueda, enviamos el filtro y el valor que desea el usuario de ese filtro
          future: listOfPacientes,
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
            listOfPacientes = pacienteService.getPacientes(
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
    return Container(
      // Se agrega la lista de Widgets, cada uno con la informacion de un doctor
      child: _PacienteItem(
          item.idPaciente,
          item.p_nombre,
          item.s_nombre,
          item.p_apellido,
          item.s_apellido,
          item.sexo,
          item.altura,
          item.peso,
          item.telefono,
          item.antecedentes,
          item.operacion,
          item.status_suscripcion,
          item.alergia,
          item.correo,
          item.fecha_nacimiento),
    );
  }

  Widget _PacienteItem(
      String? idPaciente,
      String? p_nombre,
      String? s_nombre,
      String? p_apellido,
      String? s_apellido,
      String? sexo,
      String? altura,
      String? peso,
      String? telefono,
      String? antecedentes,
      String? operacion,
      String? status_suscripcion,
      String? alergia,
      String? correo,
      String? fecha_nacimiento) {
    String? sexoAux = sexo == 'M' ? "Sexo: Masculino" : "Sexo: Femenino";
    return ListTile(
        title: Text(p_nombre! + ' ' + p_apellido!),
        subtitle: Text(sexoAux +
            '     ' +
            'Correo:   $correo' +
            '     ' +
            'Telefono:   $telefono'));
  }

  // Verifica la cantidad de especialidades del medico

  // Widget _mostrarBoton(
  //     BuildContext context, String idDoctor, PacienteService doctorService) {
  //   return SizedBox(
  //     height: 50.0,
  //     child: ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           primary: Color.fromARGB(255, 255, 0, 0),
  //         ),
  //         child: const Text(
  //           'Bloquear',
  //           style: TextStyle(fontSize: 22),
  //         ),
  //         onPressed: () {
  //           PacienteService.bloquearDoctor(idDoctor);
  //           popUpDone(context, "Doctor Bloqueado Exitosamente");
  //           setState(() {
  //             listOfPacientes = pacienteService.getPacientes(
  //                 _dropdownSelectedFilterItem, _textFieldFilter.text);
  //           });
  //         }),
  //   );
  // }
}
