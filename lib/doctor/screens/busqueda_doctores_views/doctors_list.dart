import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/models/doctors_model.dart';
import 'package:myonlinedoctorweb/doctor/screens/busqueda_doctores_views/doctor_item.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final DoctorModel item;
  final dynamic dropDownSelected;
  final String criterio;

  const DoctorList(this.item, {Key? key, required this.dropDownSelected, required this.criterio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Se agrega la lista de Widgets, cada uno con la informacion de un doctor
      child: DoctorItem(item.idDoctor, item.name, item.gender, item.mail,
          item.specialties, item.photo, item.rating, item.status, dropDownSelected, criterio),
    );
  }
}
