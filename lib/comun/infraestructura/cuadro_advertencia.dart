
import 'package:flutter/material.dart';

class EmptyTextFiledWarning extends StatelessWidget {
  final String? message;
  const EmptyTextFiledWarning({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message != null ? message! : 'Por favor ingrese los datos necesarios'),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}