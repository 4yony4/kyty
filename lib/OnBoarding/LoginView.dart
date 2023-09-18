import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Text texto=Text("Hola Mundo desde Kyty");
    //return texto;

    Column columna = Column(children: [
        Text("Login"),
      Text("Input User"),
      Text("Input Pass"),
      Row(children: [
        TextButton(onPressed: () { print("ACEPTADO");}, child: Text("Aceptar"),),
        TextButton( onPressed: () {  }, child: Text("Cancelar"),)
      ],)

        
    ],);

    return columna;
  }

}