

import 'package:flutter/material.dart';
import 'package:kyty/Main/HomeView.dart';
import 'package:kyty/Splash/SplashView.dart';

import 'OnBoarding/LoginView.dart';
import 'OnBoarding/PerfilView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
   MaterialApp materialApp=MaterialApp(title: "KyTy Miau!",
       routes: {
         '/loginview':(context) => LoginView(),
         '/registerview':(context) => RegisterView(),
         '/homeview':(context) => HomeView(),
         '/splashview':(context) => SplashView(),
         '/perfilview':(context) => PerfilView(),

       },
     initialRoute: '/homeview',
   );

   return materialApp;
  }

}