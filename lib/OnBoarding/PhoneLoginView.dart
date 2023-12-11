import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/KTTextField.dart';

import '../FirestoreObjects/FbUsuario.dart';
import '../Singletone/DataHolder.dart';

class PhoneLoginView extends StatefulWidget{
  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {

  TextEditingController tecPhone=TextEditingController();
  TextEditingController tecVerify=TextEditingController();
  String sVerificationCode="";
  bool blMostrarVerificacion=false;

  void enviarTelefonoPressed() async{
    String sTelefono=tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: sTelefono,
        verificationCompleted: verificacionCompletada,
        verificationFailed: verificacionFallida,
        codeSent: codigoEnviado,
        codeAutoRetrievalTimeout: tiempoDeEsperaAcabado);
  }

  void enviarVerifyPressed() async{
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);

    FbUsuario? usuario= await DataHolder().loadFbUsuario();
    await DataHolder().geolocAdmin.determinePosition();
    DataHolder().suscribeACambiosGPSUsuario();

    if(usuario!=null){
      print("EL NOMBRE DEL USUARIO LOGEADO ES: "+usuario.nombre);
      print("LA EDAD DEL USUARIO LOGEADO ES: "+usuario.edad.toString());
      Navigator.of(context).popAndPushNamed("/homeview");
    }
    else{
      Navigator.of(context).popAndPushNamed("/perfilview");
    }
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);

    FbUsuario? usuario= await DataHolder().loadFbUsuario();
    await DataHolder().geolocAdmin.determinePosition();
    DataHolder().suscribeACambiosGPSUsuario();

    if(usuario!=null){
      print("EL NOMBRE DEL USUARIO LOGEADO ES: "+usuario.nombre);
      print("LA EDAD DEL USUARIO LOGEADO ES: "+usuario.edad.toString());
      Navigator.of(context).popAndPushNamed("/homeview");
    }
    else{
      Navigator.of(context).popAndPushNamed("/perfilview");
    }
  }

  void verificacionFallida(FirebaseAuthException excepcion){
    if (excepcion.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codigoEnviado(String codigo, int? resendToken) async{
    sVerificationCode=codigo;
    setState(() {
      blMostrarVerificacion=true;
    });


  }

  void tiempoDeEsperaAcabado(String verID){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          KTTextField(sHint: "Numero Telefono",tecController: tecPhone),
          TextButton(onPressed: enviarTelefonoPressed, child: Text("Enviar")),
          if(blMostrarVerificacion)
            KTTextField(sHint: "Numero Verificacion",tecController: tecVerify),
          if(blMostrarVerificacion)
            TextButton(onPressed: enviarVerifyPressed, child: Text("Enviar"))
        ],

      ),

    );
  }
}