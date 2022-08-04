import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/screens/widgets/popUpDone.dart';
import 'package:myonlinedoctorweb/comun/validations.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/services/doctor_service.dart';

class DoctorItem extends StatefulWidget {
  final String idDoctor;
  final String name;
  final String gender;
  final String mail;
  final List<dynamic> specialties;
  final String photo;
  final dynamic rating;
  final String status;
  final dynamic dropDownSelected;
  final String criterio;

  const DoctorItem(
      this.idDoctor,
      this.name,
      this.gender,
      this.mail,
      this.specialties,
      this.photo,
      this.rating,
      this.status,
      this.dropDownSelected,
      this.criterio,
      {Key? key})
      : super(key: key);

  @override
  State<DoctorItem> createState() => _DoctorItemState();
}

class _DoctorItemState extends State<DoctorItem> {
  DoctorService doctorService = DoctorService();
  // ListTile de cada doctor
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: verifyPhoto(widget.photo),
        radius: 30,
      ),
      title: Text('${verifyGender(widget.gender)} ${widget.name}'),
      subtitle: Row(
        children: [
          Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    verifySpecialty(widget.specialties),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.rating}',
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
      trailing: widget.status == 'Activo'
          ? _mostrarBoton(context, widget.idDoctor, doctorService,
              widget.dropDownSelected, widget.criterio)
          : const Text('Bloqueado', style: TextStyle(color: Colors.redAccent)),
    );
  }
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

Widget _mostrarBoton(BuildContext context, String idDoctor,
    DoctorService doctorService, dynamic dropDownSelected, String criterio) {
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
          doctorService.getDoctors(dropDownSelected, criterio);
        }),
  );
}
