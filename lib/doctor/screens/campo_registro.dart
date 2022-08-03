import 'package:flutter/material.dart';

class CampoRegistro extends StatelessWidget {
  String header;
  List<String> listData;
  CampoRegistro({Key? key, required this.header, required this.listData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 800,
          height: 40,
          child: Text(header, style: const TextStyle(fontSize: 20.0)),
        ),
        SizedBox(
          height: 100,
          width: 800,
          child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Rellena este apartado...',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Campo Obligatorio';
              } else {
                return null;
              }
            },
            onSaved: (value) {
              listData.add(value!);
            },
            minLines: 4,
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
      ],
    );
  }
}
