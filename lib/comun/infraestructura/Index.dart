import 'dart:html';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/cita/providers/cita_estado.dart';
import 'package:provider/provider.dart';

import '../../cita/screens/videollamada/Llamada.dart';
import 'error_dialogo.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  bool _estaCargando = false;
  final ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('MyOnlineDoctor'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40,),
              Image.network('https://tinyurl.com/2p889y4k'),
              const SizedBox(height: 20,),
              _estaCargando ? Center(child: const CircularProgressIndicator()) : ElevatedButton(
                onPressed: onJoin,
                child: const Text('Join'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _estaCargando = true;
    });
      await window.navigator.getUserMedia(audio: true, video: true);
      try {
        await Provider.of<CitaEstado>(context, listen: false).obtenerCitasDesdApi("4b216f55-e795-4d63-a571-96e0ee455563");
        await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallPage(),
            )
        );
      }catch(e){
        ErrorDialog.showErrorDialog(e.toString(), context);
      }finally{
        setState(() {
          _estaCargando = false;
        });
      }


  }

}
