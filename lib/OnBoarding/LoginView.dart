import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/OnBoarding/RegisterView.dart';

import '../Custom/KTTextField.dart';
import '../FirestoreObjects/FbUsuario.dart';

class LoginView extends StatelessWidget{
  FirebaseFirestore db = FirebaseFirestore.instance;
  late BuildContext _context;
  TextEditingController tecUsername=TextEditingController();
  TextEditingController tecPassword=TextEditingController();

  void onClickRegistrar(){
    Navigator.of(_context).pushNamed("/registerview");
  }

  void onClickAceptar() async{
    //print("DEBUG-----_>>>>>>>>>> "+tecUsername.text);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUsername.text,
          password: tecPassword.text
      );
      //print(">>>>>>>>>>>>>>>>>>>> ME HE LOGEADO!!!!!");

      String uid=FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<FbUsuario> ref=db.collection("Usuarios")
          .doc(uid)
          .withConverter(fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore(),);


      DocumentSnapshot<FbUsuario> docSnap=await ref.get();
      FbUsuario usuario=docSnap.data()!;

      if(usuario!=null){
        print("EL NOMBRE DEL USUARIO LOGEADO ES: "+usuario.nombre);
        print("LA EDAD DEL USUARIO LOGEADO ES: "+usuario.edad.toString());
        print("LA ALTURA DEL USUARIO LOGEADO ES: "+usuario.altura.toString());
        Navigator.of(_context).popAndPushNamed("/homeview");
      }
      else{
        Navigator.of(_context).popAndPushNamed("/perfilview");
      }
      //Navigator.of(_context).popAndPushNamed("/homeview");

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
        child: KTTextField(tecController: tecUsername,
            sHint:'Escribe tu usuario'),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: KTTextField(tecController: tecPassword,
            sHint:'Escribe tu Password',
            blIsPassword: true),
      ),

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