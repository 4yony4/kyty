

import 'package:flutter/material.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
   MaterialApp materialApp=MaterialApp(title: "KyTy Miau!",
       routes: {
         '/loginview':(context) => LoginView(),
         '/registerview':(context) => RegisterView(),
       },
     initialRoute: '/loginview',
   );

   return materialApp;
  }

}