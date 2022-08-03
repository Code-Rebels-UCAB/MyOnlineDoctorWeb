
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myonlinedoctorweb/comun/screens/Bienvenido.dart';
import 'package:myonlinedoctorweb/doctor/infraestructura/servicios/doctor_servicio.dart';
import 'package:provider/provider.dart';

import '../../comun/infraestructura/cuadro_advertencia.dart';
import '../../comun/infraestructura/validaciones_credenciales.dart';
import '../infraestructura/modelos/IniciarSesionDoctorModelo.dart';
import '../providers/iniciar_sesion_doctor_estado.dart';

class IniciarSesion extends StatefulWidget {

  @override
  State<IniciarSesion> createState() => _iniciarSesionState();
}

class _iniciarSesionState extends State<IniciarSesion> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  void iniciarsesion() async {
    setState((){
      _isLoading = true;
    });
    final credenciales = IniciarSesionDoctorModelo(correoDoctor:_email.text, passwordDoctor:_password.text);
    try {
      await Provider.of<IniciarSesionEstado>(context, listen: false).iniciarSesion(credenciales);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Bienvenido()
        ),
      );
    }catch(e){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const EmptyTextFiledWarning (message:"Revise sus credenciales");
        },
      );
    } finally {
      setState((){
        _isLoading = false;
      });
    }
  }

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
                      controller: _email,
                      decoration: const InputDecoration(
                        hintText: "Correo electronico",
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
                      controller: _password,
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
                          onPressed: () async {
                            if(!Validaciones.validarCorreo(_email.text)){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const EmptyTextFiledWarning (message:"Correo Invalido");
                                },
                              );
                            }
                            if(!Validaciones.validarContrasena(_password.text)){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const EmptyTextFiledWarning (message:"La contraseña debe tener al menos 8 caracteres y una mayuscula");
                                },
                              );
                            }
                            iniciarsesion();
                            }, style: ButtonStyle(
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


