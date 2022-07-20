import 'package:flutter/material.dart';

class ErrorDialog {
  static void showErrorDialog(String message, BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text('¡Oh no!'),
      content: Text(message),
      actions: <Widget>[
        FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Aceptar'))
      ],
    ));
  }
}