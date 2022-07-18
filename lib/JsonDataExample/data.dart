import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/models/Cita.dart';

class dataSimulator {
  static List<Cita> getCitas() {
    const data = [
      {
        "Paciente": "Kevin Ferrer",
        "Date": "05/08/2022",
        "Hour": "16:30",
        "Modalidad": "Virtual",
        "Status": "Aceptada"
      },
      {
        "Paciente": "Gerardo Pelaez",
        "Date": "05/08/2022",
        "Hour": "19:30",
        "Modalidad": "Virtual",
        "Status": "Aceptada"
      },
      {
        "Paciente": "Astrid De Nobrega",
        "Date": "25/08/2022",
        "Hour": "18:00",
        "Modalidad": "Virtual",
        "Status": "Finalizada"
      },
      {
        "Paciente": "Christie Mendez",
        "Date": "25/08/2022",
        "Hour": "18:00",
        "Modalidad": "Virtual",
        "Status": "Aceptada"
      },
      {
        "Paciente": "Carlos Arriaga",
        "Date": "25/08/2022",
        "Hour": "19:30",
        "Modalidad": "Virtual",
        "Status": "Finalizada"
      },
      {
        "Paciente": "Michael Jackson",
        "Date": "25/08/2022",
        "Hour": "7:30",
        "Modalidad": "Virtual",
        "Status": "Finalizada"
      },
      {
        "Paciente": "Michael Jordan",
        "Date": "23/08/2022",
        "Hour": "9:30",
        "Modalidad": "Virtual",
        "Status": "Aceptada"
      }
    ];
    return data.map<Cita>(Cita.fromJson).toList();
  }
}
