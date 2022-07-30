

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/Bienvenido.dart';

class IniciarSesion extends StatefulWidget {

  @override
  State<IniciarSesion> createState() => _iniciarSesionState();
}

class _iniciarSesionState extends State<IniciarSesion> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          body: Stack(
            children: [
              Scaffold(
                body: Center(
                  child: Column(
                    children: [
                      Image.network(
                          "https://pbs.twimg.com/media/FY3c_ZXWQAArjd1?format=png&name=small",
                          width:300)
                    ],
                  ),
                ),
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 450),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Correo",
                        counterStyle: TextStyle(fontSize: 50),
                        border: InputBorder.none,
                      ),
                    ),
                  ), const SizedBox(
                    height: 10,
                  ), Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    margin: EdgeInsets.symmetric(horizontal: 450),
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Contraseña",
                        counterStyle: TextStyle(fontSize: 30),
                        border: InputBorder.none,
                      ),
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () async { await Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => const Bienvenido(),
                              ));}, style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)
                      ),child: const Text("Iniciar Sesion")),
                      padding: const EdgeInsets.all(15),
                      height: 70,
                      width: 200,
                    )
                  ],
                ),
              )
            ],
          )
      );
    }
}


