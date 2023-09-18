

import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
   MaterialApp materialApp=MaterialApp(title: "KyTy Miau!",
       initialRoute: '/loginview',
       routes: {
         '/loginview':(context) => LoginView(),
         '/registerview':(context) => RegisterView(),
       },);

   return materialApp;
  }

}