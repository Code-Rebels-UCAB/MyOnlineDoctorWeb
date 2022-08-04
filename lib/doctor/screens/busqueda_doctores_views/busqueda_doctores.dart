import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/popUpDone.dart';
import 'package:myonlinedoctorweb/comun/screens/NavBar.dart';
import 'package:myonlinedoctorweb/comun/validations.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/models/doctors_model.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/services/doctor_service.dart';
import 'package:myonlinedoctorweb/doctor/screens/busqueda_doctores_views/doctors_list.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({Key? key}) : super(key: key);
  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  DoctorService doctorService = DoctorService();
  dynamic listOfDoctors;
  // ignore: prefer_final_fields
  TextEditingController _textFieldFilter = TextEditingController();
  dynamic _dropdownSelectedFilterItem = ' ';
  dynamic dropdownFlag = 0;
  dynamic _searchBarEnable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfDoctors = doctorService.getDoctors(
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
          future: listOfDoctors,
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
                              ? _doctorList(context, snapshot.data)

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
            'Especialidad',
            'Top Doctores',
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
              } else if (_dropdownSelectedFilterItem == 'Top Doctores') {
                _searchBarEnable = false;
                listOfDoctors = doctorService.getDoctors(
                    _dropdownSelectedFilterItem, _textFieldFilter.text);
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
            listOfDoctors = doctorService.getDoctors(
                _dropdownSelectedFilterItem, _textFieldFilter.text);
            //futureDoctorTask(text, _dropdownSelectedFilterItem);
          });
        },
      ),
    );
  }

  // Lista de doctores
  Widget _doctorList(BuildContext context, List doctorsfuture) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Card(
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListaDoctores(doctorsfuture[index])),
        ),
        childCount: doctorsfuture.length,
      ),
    );
  }

  Widget ListaDoctores(DoctorModel item) {
    return Container(
      // Se agrega la lista de Widgets, cada uno con la informacion de un doctor
      child: _DoctorItem(item.idDoctor, item.name, item.gender, item.mail,
          item.specialties, item.photo, item.rating, item.status),
    );
  }

  Widget _DoctorItem(String idDoctor, String name, String gender, String mail,
      dynamic specialties, String photo, dynamic rating, String status) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: verifyPhoto(photo),
        radius: 30,
      ),
      title: Text('${verifyGender(gender)} ${name}'),
      subtitle: Row(
        children: [
          Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    verifySpecialty(specialties),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${rating}',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      trailing: status == 'Activo'
          ? _mostrarBoton(context, idDoctor, doctorService)
          : const Text('Bloqueado', style: TextStyle(color: Colors.redAccent)),
    );
  }

  // Verifica la cantidad de especialidades del medico
  String verifySpecialty(dynamic specialtyList) {
    String specialities = '';

    if (specialtyList.isNotEmpty) {
      if (specialtyList.length > 1) {
        for (var item in specialtyList) {
          if (item == specialtyList[0]) {
            specialities = specialtyList[0];
          } else {
            specialities = '$specialities, $item';
          }
        }
        return specialities;
      }
      return specialtyList[0];
    } else {
      return 'Medico Cirujano';
    }
  }

  Widget _mostrarBoton(
      BuildContext context, String idDoctor, DoctorService doctorService) {
    return SizedBox(
      height: 50.0,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 255, 0, 0),
          ),
          child: const Text(
            'Bloquear',
            style: TextStyle(fontSize: 22),
          ),
          onPressed: () {
            DoctorService.bloquearDoctor(idDoctor);
            popUpDone(context, "Doctor Bloqueado Exitosamente");
            setState(() {
              listOfDoctors = doctorService.getDoctors(
                  _dropdownSelectedFilterItem, _textFieldFilter.text);
            });
          }),
    );
  }
}
