import 'package:flutter/material.dart';

class CampoCita extends StatelessWidget {
  String? dato;

  CampoCita({Key? key, required this.dato}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.0,
      child: Title(
          color: Colors.black,
          child: Text(
            dato ?? '-',
            style: const TextStyle(fontSize: 16),
          )),
    );
  }
}
