import 'package:flutter/material.dart';

class CampoCita extends StatelessWidget {
  String? dato;
  double size;

  CampoCita({Key? key, required this.dato, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: Title(
          color: Colors.black,
          child: Text(
            dato ?? '-',
            style: const TextStyle(fontSize: 14),
          )),
    );
  }
}
