import 'package:flutter/material.dart';

class PlatformAdmin{

  BuildContext context;

  //PlatformAdmin(required this.contexto);
  PlatformAdmin({required this.context});
  //LOS MANINES
  double getScreenWidth(){
    double width = MediaQuery.of(context).size.width;
    return width;
  }

  double getScreenHeight(){
    double height = MediaQuery.of(context).size.height;
    return height;
  }


}