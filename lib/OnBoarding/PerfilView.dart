import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';
import 'package:kyty/OnBoarding/LoginView.dart';

import '../Custom/KTTextField.dart';

class PerfilView extends StatelessWidget{

  TextEditingController tecNombre=TextEditingController();
  TextEditingController tecEdad=TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;

  void onClickAceptar() async{

    FbUsuario usuario = new FbUsuario(nombre: tecNombre.text,
        edad: int.parse(tecEdad.text), altura: 0,colorPelo: "");


    //Crear documento con ID NUESTRO (o proporsionado por nosotros)
    String uidUsuario= FirebaseAuth.instance.currentUser!.uid;
    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed("/homeview");
  }

  void onClickCencelar(){

  }

  @override
  Widget build(BuildContext context) {
    this._context=context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        shadowColor: Colors.pink,
        backgroundColor: Colors.deepOrange,
      ),
     body:
      ConstrainedBox(constraints: BoxConstraints(
        minWidth: 500,
        minHeight: 700,
        maxWidth: 1000,
        maxHeight: 900,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          KTTextField(tecController: tecNombre,sHint: "Nombre",),
          KTTextField(tecController: tecEdad,sHint: "Edad"),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
                TextButton( onPressed: onClickCencelar, child: Text("Cancelar"),)
              ]
          )
        ],
      ),)
    );

  }



}