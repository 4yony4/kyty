import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //Text texto=Text("Hola Mundo desde Kyty");
    //return texto;


    Column columna = Column(children: [
      Text("Bienvenido a Kyty Login",style: TextStyle(fontSize: 25)),
      Text("Input User"),
      Text("Input Pass"),
      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextButton(onPressed: () { print("ACEPTADO");}, child: Text("Aceptar"),),
        TextButton( onPressed: () {  }, child: Text("Cancelar"),)
      ],)

        
    ],);

    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      shadowColor: Colors.pink,
      backgroundColor: Colors.greenAccent,
    );

    Scaffold scaf=Scaffold(body: columna,
      backgroundColor: Colors.deepOrange,
    appBar: appBar,);

    return scaf;
  }

}