


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';
import 'package:kyty/Singletone/DataHolder.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSession();
  }

  void checkSession() async{
    await Future.delayed(Duration(seconds: 3));
    if (FirebaseAuth.instance.currentUser != null) {

      FbUsuario? usuario= await DataHolder().loadFbUsuario();
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
    else{
      Navigator.of(context).popAndPushNamed("/loginview");
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Positioned(
          left: DataHolder().platformAdmin.getScreenWidth()*0.1,
          top: DataHolder().platformAdmin.getScreenHeight()*0.1,
          width: DataHolder().platformAdmin.getScreenWidth()*0.8,
          height: DataHolder().platformAdmin.getScreenHeight()*0.8,
          child: Image.asset("resources/logo_kyty2.png",)
        ),
        Positioned(
          left: DataHolder().platformAdmin.getScreenWidth()*0.1,
          top: DataHolder().platformAdmin.getScreenHeight()*0.1+DataHolder().platformAdmin.getScreenHeight()*0.8,
          width: DataHolder().platformAdmin.getScreenWidth()*0.5,
          height: DataHolder().platformAdmin.getScreenHeight()*0.5,
          child: CircularProgressIndicator()
        ),


      ],
    );
    /*Column column=Column(
      children: [


        Image.asset("resources/logo_kyty2.png",
            width: DataHolder().platformAdmin.getScreenWidth()*0.6,
            height: DataHolder().platformAdmin.getScreenHeight()*0.6),
        CircularProgressIndicator()
      ],
    );*/

    //return Image.network("https://cdn.discordapp.com/attachments/1094893510609608764/1154156474763845703/yony44_logo_using_cat_ears_and_head_like_disney_symbol_happy_an_1fccd304-c37e-410f-a9bd-155c310e365a.png");
    //return Image.network("https://i0.wp.com/www.printmag.com/wp-content/uploads/2021/02/4cbe8d_f1ed2800a49649848102c68fc5a66e53mv2.gif?fit=476%2C280&ssl=1");
    //return column;

  }


}