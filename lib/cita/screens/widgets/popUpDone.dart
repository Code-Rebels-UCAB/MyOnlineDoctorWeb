import 'package:flutter/material.dart';

popUpDone(BuildContext context, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(mensaje)),
          content: SizedBox(
            height: 150,
            width: 400,
            child: Expanded(
              child: Column(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 70.0,
                    color: Colors.greenAccent,
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  ElevatedButton(
                    child: const Text('Aceptar'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      });
}
