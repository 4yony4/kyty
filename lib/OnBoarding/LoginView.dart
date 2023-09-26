import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/RegisterView.dart';

import '../Custom/KTTextField.dart';

class LoginView extends StatelessWidget{

  late BuildContext _context;
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecPassword=TextEditingController();

  void onClickRegistrar(){
    Navigator.of(_context).pushNamed("/registerview");
  }

  void onClickAceptar() async{

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text
      );
      print(">>>>>>>>>>>>>>>>>>>> ME HE LOGEADO!!!!!");
      Navigator.of(_context).popAndPushNamed("/homeview");

    } on FirebaseAuthException catch (e) {


      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    _context=context;
    // TODO: implement build
    //Text texto=Text("Hola Mundo desde Kyty");
    //return texto;


    Column columna = Column(children: [
      Text("Bienvenido a Kyty Login",style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: TextField(
          controller: tecUsername,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu usuario',
          ),
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: TextFormField(
          controller: tecPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu password',
          ),
          obscureText: true,
        ),
      ),

      KTTextField(tecController: tecUsername,sHint:''),
      KTTextField(tecController: tecUsername,),
      KTTextField(tecController: tecUsername),
      KTTextField(tecController: tecUsername),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
        TextButton( onPressed: onClickRegistrar, child: Text("REGISTRO"),)
      ],)

        
    ],);

    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      shadowColor: Colors.pink,
      backgroundColor: Colors.greenAccent,
    );

    Scaffold scaf=Scaffold(body: columna,
      //backgroundColor: Colors.deepOrange,
    appBar: appBar,);

    return scaf;
  }

}